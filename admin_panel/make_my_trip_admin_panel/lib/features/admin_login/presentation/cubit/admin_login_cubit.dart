import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';

class AdminLoginCubit extends Cubit<BaseState> {
  AdminLoginCubit() : super(StateInitial());

  void changeObSecureEvent(bool obSecureValue){
    emit(StateOnSuccess(!obSecureValue));
  }
}
