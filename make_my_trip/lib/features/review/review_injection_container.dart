import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source_impl.dart';
import 'package:make_my_trip/features/review/data/repositories/review_repository_impl.dart';
import 'package:make_my_trip/features/review/domain/repositories/review_repository.dart';
import 'package:make_my_trip/features/review/domain/use_cases/get_hotel_review_usecase.dart';
import 'package:make_my_trip/features/review/domain/use_cases/post_hotel_review_usecase.dart';
import 'package:make_my_trip/features/review/presentation/cubit/publish_review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';

var reviewSl = GetIt.instance;

Future<void> init() async {
  //Cubit
  reviewSl
      .registerFactory(() => ReviewCubit(reviewSl(), reviewSl(), reviewSl()));
 // reviewSl.registerFactory(() => PublishReviewCubit(reviewSl()));

  //UseCase
  reviewSl.registerLazySingleton(() => GetHotelReviewUseCases(reviewSl()));
  reviewSl.registerLazySingleton(() => PostHotelReviewUseCases(reviewSl()));

  //Repository
  reviewSl.registerLazySingleton<ReviewRepository>(
      () => ReviewRepositoryImpl(reviewSl()));

  //Remote data source
  reviewSl.registerLazySingleton<ReviewRemoteDataSource>(
      () => ReviewRemoteDataSourceImpl(reviewSl()));

  //Dio
  // reviewSl.registerFactory(() => Dio());
}
