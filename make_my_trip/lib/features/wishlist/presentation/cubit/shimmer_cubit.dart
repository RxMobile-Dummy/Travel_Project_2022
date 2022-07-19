import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shimmer_state.dart';

class ShimmerCubit extends Cubit<ShimmerState> {
  ShimmerCubit() : super(ShimmerInitial()) {
    shimmerEffect();
  }

  shimmerEffect() async {
    emit(ShimmerLoading());
    await Future.delayed(const Duration(seconds: 1), () {
      emit(ShimmerLoaded());
    });
  }
}
