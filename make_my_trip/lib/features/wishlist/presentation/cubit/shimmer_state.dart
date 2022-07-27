part of 'shimmer_cubit.dart';

@immutable
abstract class ShimmerState {}

class ShimmerInitial extends ShimmerState {}

class ShimmerLoading extends ShimmerState {}

class ShimmerLoaded extends ShimmerState {}
