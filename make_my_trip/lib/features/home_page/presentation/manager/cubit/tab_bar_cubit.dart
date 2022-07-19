import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:meta/meta.dart';

class TabBarCubit extends Cubit<BaseState> {
  TabBarCubit() : super(StateInitial()) {
    OnItemTap(0);
  }

  OnItemTap(index) {
    emit(StateOnSuccess<int>(index));
    return index;
  }
}
