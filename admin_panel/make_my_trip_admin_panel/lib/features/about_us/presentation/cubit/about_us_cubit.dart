import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/about_us/domain/use_cases/about_us_update_usecase.dart';
import 'package:make_my_trip_admin_panel/features/about_us/domain/use_cases/about_us_usecase.dart';

import '../../../../core/usecases/usecase.dart';

class AboutUsCubit extends Cubit<BaseState> {
  AboutUsCubit(this.aboutUsUseCase, this.aboutUsUpdateUseCase)
      : super(StateInitial());

  final AboutUsUseCase aboutUsUseCase;
  final AboutUsUpdateUseCase aboutUsUpdateUseCase;

  getAboutUsData() async {
    final res = await aboutUsUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  updateAboutUsData(String content) async {
    final res = await aboutUsUpdateUseCase.call(UpdateParams(content));
    return res.fold(
        (l) => emit(StateErrorGeneral(l.toString())), (r) => getAboutUsData());
  }
}
