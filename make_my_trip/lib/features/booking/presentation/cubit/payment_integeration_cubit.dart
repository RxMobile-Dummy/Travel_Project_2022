import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/booking_usecase.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/payment_usecase.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../core/base/base_state.dart';

class PaymentCubit extends Cubit<BaseState> {
  PaymentCubit(this._razorpay, this.paymentUseCase, this.bookingUseCase)
      : super(StateInitial());

  final Razorpay _razorpay;
  final PaymentUseCase paymentUseCase;
  final BookingUseCase bookingUseCase;

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
    emit(StateErrorGeneral(""));
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
    } catch (e) {
      print(e);
    }
  }

  paymentConfirm(double amount) async {
    emit(StateLoading());
    final data = await paymentUseCase.call(PaymentParams(amount));
    data.fold((l) {
      print(l);
    }, (r) {
      init();
      openCheckout(
          r.amount!, r.orderId!, r.username, r.userEmail, r.userNumber);
    });
  }

  bookingConfirm(int hotelId, String cIn, String cOut, List<int> roomId) async {
    final data =
        await bookingUseCase.call(BookingParams(hotelId, cIn, cOut, roomId));
    data.fold((l) => emit(StateNoData()),
        (r) => emit(StateOnSuccess<BookingModel>(r)));
  }

  @override
  Future<void> close() async {
    return _razorpay.clear();
  }
}
