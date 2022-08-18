import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/faq/presentation/cubit/faq_cubit.dart';

import 'data/data_sources/faq_remote_data_sources.dart';
import 'data/repositories/faq_repository_impl.dart';
import 'domain/repositories/faq_respository.dart';
import 'domain/use_cases/faq_usecase.dart';

final slFaqPage = GetIt.instance;

Future<void> init() async {
  // slPrivacyPage.registerLazySingleton(() => FirebaseFirestore.instance);

  //cubit
  slFaqPage.registerFactory(() => FaqCubit(slFaqPage()));

  //Usecase
  slFaqPage.registerLazySingleton(() => FaqUseCase(slFaqPage()));
  // slFaqPage
  //     .registerLazySingleton(() => PrivacyPolicyUpdateUseCase(slFaqPage()));

  //Repository
  slFaqPage.registerLazySingleton<FaqRepository>(
      () => FaqRepositoryImpl(slFaqPage()));

  //Data source
  slFaqPage.registerLazySingleton<FaqRemoteDataSources>(
      () => FaqRemoteDataSourcesImpl(slFaqPage()));
}
