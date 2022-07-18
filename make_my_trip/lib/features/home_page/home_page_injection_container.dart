import 'package:dio/dio.dart';
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
  sl.registerLazySingleton<ImagesDataSource>(() => ImagesDataSourceImpl(sl()));
  sl.registerLazySingleton<ToursDataSource>(() => ToursDataSourceImpl(sl()));

  //repository
  sl.registerLazySingleton<ImagesDataSourceImpl>(
      () => ImagesDataSourceImpl(sl()));
  sl.registerLazySingleton<ToursDataSourceImpl>(
      () => ToursDataSourceImpl(sl()));
  sl.registerLazySingleton<ImagesRepository>(
      () => ImageRepositoryImpl(imagesdatasource: ImagesDataSourceImpl(sl())));
  sl.registerLazySingleton<ToursRepository>(
      () => ToursRepositoryImpl(toursDataSource: ToursDataSourceImpl(sl())));

  //use case
  sl.registerLazySingleton<ImagesUseCase>(() => ImagesUseCase(
      imagesrepository: ImageRepositoryImpl(imagesdatasource: ImagesDataSourceImpl(sl.call()))));
  sl.registerLazySingleton<ToursUseCase>(() => ToursUseCase(
      toursRepository: ToursRepositoryImpl(toursDataSource: ToursDataSourceImpl(sl.call()))));

  //cubit
  sl.registerFactory<HomepageCubit>(() => HomepageCubit(sl(), sl()));

  sl.registerLazySingleton(() => Dio());
}
