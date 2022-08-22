import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';
import 'package:make_my_trip/features/user/domain/usecases/is_anonymous_user.dart';
import 'package:platform_device_id/platform_device_id.dart';

final splashSl = GetIt.instance;

Future<void> init() async {
  print("device id :  ${await PlatformDeviceId.getDeviceId}");
  splashSl.registerFactory(
      () => SplashCubit(getUser: splashSl(), refreshFcmToken: splashSl()));
}
