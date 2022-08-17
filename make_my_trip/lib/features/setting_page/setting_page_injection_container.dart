import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source_impl.dart';
import 'package:make_my_trip/features/setting_page/data/repositories/setting_page_repository_impl.dart';
import 'package:make_my_trip/features/setting_page/domain/repositories/setting_page_repository.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/get_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_image_usecase.dart';
import 'package:make_my_trip/features/setting_page/domain/use_cases/update_user_data_usecase.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'data/data_sources/user_details_remote_data_source.dart';
import 'domain/use_cases/about_us_usecase.dart';
import 'domain/use_cases/faq_usecase.dart';
import 'domain/use_cases/privacy_policy_usecase.dart';
import 'domain/use_cases/terms_and_condition_usecase.dart';

final slSettingPage = GetIt.instance;

Future<void> init() async {
  slSettingPage.registerLazySingleton(() => FirebaseFirestore.instance);

  //cubit
  slSettingPage.registerFactory(() => SettingPageCubit(
      slSettingPage(), slSettingPage(), slSettingPage(), slSettingPage(),slSettingPage(),slSettingPage(),slSettingPage()));

  //Data source
  slSettingPage.registerLazySingleton<UserDetailsRemoteDataSource>(
      () => UserDetailsRemoteDataSourceImpl(slSettingPage(), slSettingPage()));

  //Repository
  slSettingPage.registerLazySingleton<SettingPageRepository>(
      () => SettingPageRepositoryImpl(slSettingPage()));

  //Usecase
  slSettingPage
      .registerLazySingleton(() => GetUserDataUseCase(slSettingPage()));

  slSettingPage
      .registerLazySingleton(() => UpdateImageUseCase(slSettingPage()));

  slSettingPage
      .registerLazySingleton(() => UpdateUserDataUseCase(slSettingPage()));
  slSettingPage.registerLazySingleton(() => FaqUseCase(slSettingPage()));
  slSettingPage.registerLazySingleton(() => AboutUsUseCase(slSettingPage()));
  slSettingPage.registerLazySingleton(() => PrivacyPolicyUseCase(slSettingPage()));
  slSettingPage.registerLazySingleton(() => TermsConditionUseCase(slSettingPage()));
}
