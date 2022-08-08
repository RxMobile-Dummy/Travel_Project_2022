import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/payment_usecase.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../core/base/base_state.dart';

class PaymentCubit extends Cubit<BaseState> {
  PaymentCubit(this._razorpay, this.paymentUseCase) : super(StateInitial());

  final Razorpay _razorpay;
  final PaymentUseCase paymentUseCase;

  init() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIosWeb: 4);
  }

  void openCheckout(double amount, String orderId) async {
    var options = {
      'key': 'rzp_test_LqRkyAt6cQpVui',
      'amount': amount,
      'name': 'Himanshu',
      'order_id': orderId,
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
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

  paymentConfirm() async {
    emit(StateLoading());
    final data = await paymentUseCase.call(PaymentParams(2000));
    data.fold((l) => emit(StateNoData()), (r) {
      init();
      openCheckout(r.amount!, r.orderId!);
    });
  }

  @override
  Future<void> close() async {
    return _razorpay.clear();
  }
}
