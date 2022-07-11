import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource_impl.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource_impl.dart';
import 'package:make_my_trip/features/home_page/data/repositories/image_repository_impl.dart';
import 'package:make_my_trip/features/home_page/data/repositories/tours_repository_impl.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/tours_repository.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:make_my_trip/features/home_page/presentation/manager/cubit/homepage_cubit.dart';

final sl = GetIt.instance;

Future<void> initializehomepage() async {
  //data source
  sl.registerLazySingleton<Imagesdatasource>(() => Imagesdatasource_impl());
  sl.registerLazySingleton<ToursDataSource>(() => Tours_DataSource_impl());

  //repository
  sl.registerLazySingleton<Imagesdatasource_impl>(
      () => Imagesdatasource_impl());
  sl.registerLazySingleton<Tours_DataSource_impl>(
      () => Tours_DataSource_impl());
  sl.registerLazySingleton<Imagesrepository>(
      () => Imagerepository_impl(imagesdatasource: Imagesdatasource_impl()));
  sl.registerLazySingleton<ToursRepository>(
      () => ToursRepository_impl(toursDataSource: Tours_DataSource_impl()));

  //use case
  sl.registerLazySingleton<images_usecase>(() => images_usecase(
      imagesrepository: Imagerepository_impl(imagesdatasource: sl.call())));
  sl.registerLazySingleton<Tours_usecase>(() => Tours_usecase(
      toursRepository: ToursRepository_impl(toursDataSource: sl.call())));

  //cubit
  sl.registerFactory<HomepageCubit>(() => HomepageCubit(sl.call(), sl.call()));
}
