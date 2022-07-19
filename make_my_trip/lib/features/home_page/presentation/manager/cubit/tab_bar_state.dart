part of 'tab_bar_cubit.dart';

@immutable
abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class OnItemTapState extends TabBarState {
  int index;
  OnItemTapState(this.index);
}
