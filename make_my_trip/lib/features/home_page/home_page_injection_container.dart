import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';

import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource_impl.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource_impl.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/viewCoupon_datasource.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/viewCoupon_datasource_impl.dart';
import 'package:make_my_trip/features/home_page/data/repositories/image_repository_impl.dart';
import 'package:make_my_trip/features/home_page/data/repositories/tours_repository_impl.dart';
import 'package:make_my_trip/features/home_page/data/repositories/viewCoupon_repository_impl.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/images_repository.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/tours_repository.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/viewCoupon_repository.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/image_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/tour_usecase.dart';
import 'package:make_my_trip/features/home_page/domain/use_cases/viewCoupon_usecase.dart';
import 'package:make_my_trip/features/home_page/presentation/cubit/homepage_cubit.dart';
import 'package:make_my_trip/features/home_page/presentation/cubit/tab_bar_cubit.dart';

final slHomePage = GetIt.instance;

Future<void> init() async {
  //cubit
  slHomePage.registerFactory<HomepageCubit>(
      () => HomepageCubit(slHomePage(), slHomePage(), slHomePage()));
  slHomePage.registerFactory(() => TabBarCubit(isAnonymousUser: slHomePage()));
  //data source
  slHomePage.registerLazySingleton<ImagesDataSource>(
      () => ImagesDataSourceImpl(slHomePage()));
  slHomePage.registerLazySingleton<ToursDataSource>(
      () => ToursDataSourceImpl(slHomePage()));
  slHomePage.registerLazySingleton<ViewCouponsDataSource>(
          () => ViewCouponsDataSourceImpl(slHomePage()) );

  //repository
  slHomePage.registerLazySingleton<ImagesRepository>(() => ImageRepositoryImpl(
      imagesDataSource: ImagesDataSourceImpl(slHomePage())));
  slHomePage.registerLazySingleton<ToursRepository>(() =>
      ToursRepositoryImpl(toursDataSource: ToursDataSourceImpl(slHomePage())));
  slHomePage.registerLazySingleton<ViewCouponRepository>(
          () => ViewCouponRepositoryImpl(viewCouponsDataSource: ViewCouponsDataSourceImpl(slHomePage())));

  //use case
  slHomePage.registerLazySingleton<GetAllImagesOfHomePageUseCase>(() =>
      GetAllImagesOfHomePageUseCase(
          imagesrepository: ImageRepositoryImpl(
              imagesDataSource: ImagesDataSourceImpl(slHomePage.call()))));
  slHomePage.registerLazySingleton<GetAllToursOfHomepageUseCase>(() =>
      GetAllToursOfHomepageUseCase(
          toursRepository: ToursRepositoryImpl(
              toursDataSource: ToursDataSourceImpl(slHomePage.call()))));
  slHomePage.registerLazySingleton<GetAllCouponsOfHomepage>(() =>
      GetAllCouponsOfHomepage(
          viewCouponRepository  : ViewCouponRepositoryImpl(
              viewCouponsDataSource: ViewCouponsDataSourceImpl(slHomePage.call()))));

  slHomePage.registerLazySingleton(() => Dio());
}
