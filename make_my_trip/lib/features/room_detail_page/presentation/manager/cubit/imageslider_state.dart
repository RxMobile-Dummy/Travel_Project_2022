part of 'imageslider_cubit.dart';

@immutable
abstract class ImagesliderState {}

class ImagesliderInitial extends ImagesliderState {}

class GetIndexState extends ImagesliderState {
  int i;
  GetIndexState(this.i);
}
