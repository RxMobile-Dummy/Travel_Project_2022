import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/faq/domain/use_cases/faq_usecase.dart';
import 'package:make_my_trip_admin_panel/features/faq/domain/use_cases/update_faq_usecase.dart';

import '../../../../core/usecases/usecase.dart';

class FaqCubit extends Cubit<BaseState> {
  FaqCubit(this.faqUseCase, this.faqUpdateUseCase) : super(StateInitial());

  final FaqUseCase faqUseCase;
  final FaqUpdateUseCase faqUpdateUseCase;

  getFaqData() async {
    final res = await faqUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }

  updateFaqData(String title, String content) async {
    final res = await faqUpdateUseCase.call(FaqParams(title, content));
    return res.fold(
        (l) => emit(StateErrorGeneral(l.toString())), (r) => getFaqData());
  }
}
