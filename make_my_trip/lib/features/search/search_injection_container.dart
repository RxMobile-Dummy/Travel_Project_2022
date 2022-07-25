import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_cubit.dart';
import 'package:make_my_trip/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:make_my_trip/features/user/domain/usecases/get_user.dart';
import 'package:make_my_trip/features/user/domain/usecases/is_anonymous_user.dart';

final searchSl = GetIt.instance;

Future<void> init() async {
  searchSl.registerFactory(() => SearchCubit(isAnonymousUser: searchSl()));
}
