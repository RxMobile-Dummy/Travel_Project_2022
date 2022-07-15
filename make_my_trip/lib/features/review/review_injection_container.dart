import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source_impl.dart';
import 'package:make_my_trip/features/review/data/repositories/review_repository_impl.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';
import 'package:make_my_trip/features/review/domain/use_cases/get_hotel_review_usecase.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';

var sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  sl.registerFactory(() => ReviewCubit(sl()));

  //UseCase
  sl.registerLazySingleton(() => GetHotelReviewUseCases(sl()));

  //Repository
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));

  //Remote data source
  sl.registerLazySingleton<ReviewRemoteDataSource>(
      () => ReviewRemoteDataSourceImpl(sl()));

  //Dio
  sl.registerLazySingleton(() => Dio());
}
