import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit() : super(IntroInitial());

  nextIndicator(double index) {
    if (index < 5) {
      print(index);
      emit(IndicatorIndexState(index: index));
    }
  }
}
