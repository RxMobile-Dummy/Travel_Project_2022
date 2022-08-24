import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/use_cases/privacy_policy_usecase.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/use_cases/update_privacy_policy_usecase.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../about_us/domain/use_cases/about_us_update_usecase.dart';

class PrivacyPolicyCubit extends Cubit<BaseState> {
  PrivacyPolicyCubit(this.privacyPolicyUseCase, this.policyUpdateUseCase)
      : super(StateInitial());

  final PrivacyPolicyUseCase privacyPolicyUseCase;
  final PrivacyPolicyUpdateUseCase policyUpdateUseCase;

  getPrivacyPolicyData() async {
    final res = await privacyPolicyUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  updatePrivacyPolicyData(String content) async {
    final res = await policyUpdateUseCase.call(UpdateParams(content));
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => getPrivacyPolicyData());
  }
}
