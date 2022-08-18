import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/datasources/review_moderation_remote_data_source.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/repositories/review_moderation_repository.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/approve_or_reject_review_usecase.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/get_all_reviews_usecase.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/review_Image_delete.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/presentation/cubit/review_moderation_cubit.dart';
import 'data/repositories/review_moderation_repository_impl.dart';

final reviewSl = GetIt.instance;

Future<void> init() async {
  reviewSl.registerFactory(() => ReviewModerationCubit(
      getAllReviews: reviewSl(),
      approveOrRejectReview: reviewSl(),
      reviewImageDelete: reviewSl()));

  reviewSl.registerLazySingleton(() => GetAllReviews(repository: reviewSl()));
  reviewSl.registerLazySingleton(
      () => ApproveOrRejectReview(repository: reviewSl()));
  reviewSl
      .registerLazySingleton(() => ReviewImageDelete(repository: reviewSl()));

  reviewSl.registerLazySingleton<ReviewModerationRepository>(
      () => ReviewModerationRepositoryImpl(remoteDataSource: reviewSl()));

  reviewSl.registerLazySingleton<ReviewModerationRemoteDataSource>(
      () => ReviewModerationRemoteDataSourceImpl(dio: reviewSl()));
}
