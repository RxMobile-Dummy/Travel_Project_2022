import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/terms_condition/presentation/cubit/terms_condition_cubit.dart';

import 'data/data_sources/terms_condition_remote_data_sources.dart';
import 'data/repositories/terms_condition_repository_impl.dart';
import 'domain/repositories/terms_condition_repository.dart';
import 'domain/use_cases/terms_condition_usecase.dart';
import 'domain/use_cases/update_terms_condition_usecase.dart';

final slTcPage = GetIt.instance;

Future<void> init() async {
  // slPrivacyPage.registerLazySingleton(() => FirebaseFirestore.instance);

  //cubit
  slTcPage.registerFactory(() => TermsConditionCubit(slTcPage(), slTcPage()));

  //Usecase
  slTcPage.registerLazySingleton(() => TermsConditionUseCase(slTcPage()));
  slTcPage.registerLazySingleton(() => TermsConditionUpdateUseCase(slTcPage()));

  //Repository
  slTcPage.registerLazySingleton<TermsConditionRepository>(
      () => TermsConditionRepositoryImpl(slTcPage()));

  //Data source
  slTcPage.registerLazySingleton<TermsConditionRemoteDataSources>(
      () => TermsConditionRemoteDataSourcesImpl(slTcPage()));
}
