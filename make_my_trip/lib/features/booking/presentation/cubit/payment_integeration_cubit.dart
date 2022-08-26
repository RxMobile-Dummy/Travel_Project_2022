import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/booking_usecase.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/checkCoupon.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/payment_usecase.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/showApplicableCouponsUsecase.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../core/base/base_state.dart';
import '../../../room_categories/domain/use_cases/room_book_post_usecase.dart';

class PaymentCubit extends Cubit<BaseState> {
  PaymentCubit(
      this._razorpay,
      this.paymentUseCase,
      this.bookingUseCase,
      this.roomBookPostUsecase,
      this.showApplicableCouponsUsecase,
      this.checkCouponUsecase)
      : super(StateInitial());

  final Razorpay _razorpay;
  final PaymentUseCase paymentUseCase;
  final BookingUseCase bookingUseCase;
  final RoomBookPostUsecase roomBookPostUsecase;
  final ShowApplicableCouponsUsecase showApplicableCouponsUsecase;
  final CheckCouponUsecase checkCouponUsecase;

  init() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    emit(StateShowSearching());
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    emit(StateNoData());
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);
  }

  void openCheckout(double amount, String orderId, String? name, String? email,
      String? number) async {
    var options = {
      'key': 'rzp_test_LqRkyAt6cQpVui',
      'amount': amount,
      'name': name,
      'order_id': orderId,
      'description': 'Payment',
      'prefill': {
        'contact': number ?? "8888888888",
        'email': email ?? "testuser@gmail.com"
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  paymentConfirm(double amount) async {
    emit(StateLoading());
    final data = await paymentUseCase.call(PaymentParams(amount));
    data.fold((l) {
      emit(StateErrorGeneral(l.toString()));
    }, (r) {
      init();
      openCheckout(
          r.amount!, r.orderId!, r.username, r.userEmail, r.userNumber);
    });
  }

  bookingConfirm(int hotelId, String cIn, String cOut, List<int> roomId,
      int adults, int coupon_id) async {
    final data = await bookingUseCase
        .call(BookingParams(hotelId, cIn, cOut, roomId, adults, coupon_id));
    data.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess<BookingModel>(r)));
  }

  roomBookPost(
      String orderId, String paymentId, BookingModel bookingModel) async {
    var res = await roomBookPostUsecase
        .call(RoomBookParams(orderId, paymentId, bookingModel));
    res.fold((l) => {emit(StateErrorGeneral(l.toString()))},
        (r) => {emit(StateOnKnownToSuccess(r))});
  }

  @override
  Future<void> close() async {
    return _razorpay.clear();
  }

  showApplicableCoupons(int price) async {
    print('cubit');
    var data = await showApplicableCouponsUsecase
        .call(ShowApplicableCouponParams(price));
    data.fold((failure) {
      print('fail');
      if (failure is ServerFailure) {
        emit(StateErrorGeneral('No data Found'));
      }
      debugPrint(failure.toString());
    }, (success) {
      print('success');
      print(success);
      emit(StateOnSuccess<List<ViewCouponModel>>(success));
      // emit(StateOnSuccess();
    });
  }

  applyButton(flag) {
    emit(StateSearchResult<bool>(flag));
  }

  checkCoupon(int price, String code) async {
    var data = await checkCouponUsecase.call(CheckCouponParams(price, code));
    data.fold((failure) {
      emit(StateErrorGeneral('Invalid Coupon!'));
      debugPrint(failure.toString());
    }, (success) {
      print('success');
      if (success.isEmpty) {
        emit(StateErrorGeneral('Invalid Coupon!'));
      } else {
        emit(StateOnResponseSuccess<List<ViewCouponModel>>(success));
      }
      // emit(StateOnSuccess();
    });
  }
}
