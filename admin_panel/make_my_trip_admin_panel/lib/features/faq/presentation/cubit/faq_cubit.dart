import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/faq/domain/use_cases/faq_usecase.dart';

import '../../../../core/usecases/usecase.dart';

class FaqCubit extends Cubit<BaseState> {
  FaqCubit(this.faqUseCase) : super(StateInitial());

  final FaqUseCase faqUseCase;

  getFaqData() async {
    final res = await faqUseCase.call(NoParams());
    return res.fold((l) => emit(StateErrorGeneral(l.toString())),
        (r) => emit(StateOnSuccess(r)));
  }
}
