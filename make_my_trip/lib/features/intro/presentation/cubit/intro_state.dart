abstract class IntroState {}

class IntroInitial extends IntroState {}

class IndicatorIndexState extends IntroState {
  final double index;
  IndicatorIndexState({required this.index});
}

class IntroSucessState extends IntroState {}
