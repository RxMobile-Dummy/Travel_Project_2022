import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_state.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/usecases/logIn_anonymously.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit({required this.logInAnonymously}) : super(IntroInitial());
  final LogInAnonymously logInAnonymously;
  nextIndicator(double index) {
    emit(IndicatorIndexState(index: index));
  }

  anonymouslyLogIn() async {
    final response = await logInAnonymously.call(NoParams());
    response.fold((failure) {
      emit(IndicatorErrorState(error: _getFailure(failure)));
    }, (success) {
      emit(IntroSucessState());
    });
  }

  String _getFailure(failure) {
    if (failure is ServerFailure) {
      return failure.failureMsg!;
    } else {
      if (failure is AuthFailure) {
        return failure.failureMsg!;
      } else {
        return "Unexpected Error";
      }
    }
  }
}
