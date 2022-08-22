import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/use_cases/about_us_usecase.dart';
import '../../domain/use_cases/faq_usecase.dart';
import '../../domain/use_cases/privacy_policy_usecase.dart';
import '../../domain/use_cases/terms_and_condition_usecase.dart';

class InformationPageCubit extends Cubit<BaseState> {
  InformationPageCubit(this.faqUseCase, this.aboutUsUseCase,
      this.privacyPolicyUseCase, this.termsConditionUseCase)
      : super(StateInitial());

  FaqUseCase faqUseCase;
  AboutUsUseCase aboutUsUseCase;
  PrivacyPolicyUseCase privacyPolicyUseCase;
  TermsConditionUseCase termsConditionUseCase;

  getFaqData() async {
    final res = await faqUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  getAboutUsData() async {
    final res = await aboutUsUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  getPrivacyPolicyData() async {
    final res = await privacyPolicyUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  getTermsConditionData() async {
    final res = await termsConditionUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    return res;
  }

  sendingMails(String email) async {
    var url = Uri.parse(email);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
