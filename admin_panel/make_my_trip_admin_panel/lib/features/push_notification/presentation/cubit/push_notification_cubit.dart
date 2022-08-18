
import 'package:bloc/bloc.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/domain/use_cases/push_notification_usecase.dart';
import 'package:meta/meta.dart';


part 'push_notification_state.dart';

class PushNotificationCubit extends Cubit<PushNotificationState> {
  PushNotificationUseCase pushNotificationUseCase;
  PushNotificationCubit(this.pushNotificationUseCase) : super(PushNotificationInitial());

  getImagefromDevice() async {
    final response = await pushNotificationUseCase.call();
    response.fold((l) => null, (r) =>   emit(PushNotificationResponse(r.first.toString(),r.last.toString())));

  }
}
