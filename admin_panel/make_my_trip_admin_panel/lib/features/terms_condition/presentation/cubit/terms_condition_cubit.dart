import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/domain/use_cases/terms_condition_usecase.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/domain/use_cases/update_terms_condition_usecase.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../about_us/domain/use_cases/about_us_update_usecase.dart';

class TermsConditionCubit extends Cubit<BaseState> {
  TermsConditionCubit(
      this.termsConditionUseCase, this.termsConditionUpdateUseCase)
      : super(StateInitial());

  final TermsConditionUseCase termsConditionUseCase;
  final TermsConditionUpdateUseCase termsConditionUpdateUseCase;

  getTermsConditionData() async {
    final res = await termsConditionUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  updateTermsConditionData(String content) async {
    final res = await termsConditionUpdateUseCase.call(UpdateParams(content));
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => getTermsConditionData());
  }
}
