import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'internet_cubit.dart';

final internetSl = GetIt.instance;

Future<void> init() async {
  internetSl.registerFactory(
    () => InternetCubit(
      connectivity: internetSl.call(),
    ),
  );
  internetSl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );
}
