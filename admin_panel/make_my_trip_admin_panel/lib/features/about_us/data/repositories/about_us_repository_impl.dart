import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/about_us/data/data_sources/about_us_remote_data_sources.dart';
import 'package:make_my_trip_admin_panel/features/about_us/domain/repositories/about_us_repository.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';

class AboutUsRepositoryImpl extends AboutUsRepository {
  final AboutUsRemoteDataSources aboutUsRemoteDataSources;
  AboutUsRepositoryImpl(this.aboutUsRemoteDataSources);

  @override
  Future<Either<Failures, List<ContentModel>>> getAboutUs() async {
    return await aboutUsRemoteDataSources.getAboutUsData();
  }

  @override
  Future<Either<Failures, String>> updateAboutUs(String content) async {
    return await aboutUsRemoteDataSources.updateAboutUsData(content);
  }
}
