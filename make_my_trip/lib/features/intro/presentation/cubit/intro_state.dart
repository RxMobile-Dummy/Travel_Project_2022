abstract class IntroState {}

class IntroInitial extends IntroState {}

class IndicatorIndexState extends IntroState {
  final double index;
  IndicatorIndexState({required this.index});
}

class IndicatorErrorState extends IntroState {
  final String error;
  IndicatorErrorState({required this.error});
}

class IntroSucessState extends IntroState {}
