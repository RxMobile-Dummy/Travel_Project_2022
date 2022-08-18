import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/data/data_sources/privacy_policy_remote_data_sources.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/data/repositories/privacy_policy_repository_impl.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/repositories/privacy_policy_repository.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/domain/use_cases/privacy_policy_usecase.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/presentation/cubit/privacy_policy_cubit.dart';

import 'domain/use_cases/update_privacy_policy_usecase.dart';

final slPrivacyPage = GetIt.instance;

Future<void> init() async {
  // slPrivacyPage.registerLazySingleton(() => FirebaseFirestore.instance);

  //cubit
  slPrivacyPage.registerFactory(
      () => PrivacyPolicyCubit(slPrivacyPage(), slPrivacyPage()));

  //Usecase
  slPrivacyPage
      .registerLazySingleton(() => PrivacyPolicyUseCase(slPrivacyPage()));
  slPrivacyPage
      .registerLazySingleton(() => PrivacyPolicyUpdateUseCase(slPrivacyPage()));

  //Repository
  slPrivacyPage.registerLazySingleton<PrivacyPolicyRepository>(
      () => PrivacyPolicyRepositoryImpl(slPrivacyPage()));

  //Data source
  slPrivacyPage.registerLazySingleton<PrivacyPolicyRemoteDataSources>(
      () => PrivacyPolicyRemoteDataSourcesImpl(slPrivacyPage()));
}
