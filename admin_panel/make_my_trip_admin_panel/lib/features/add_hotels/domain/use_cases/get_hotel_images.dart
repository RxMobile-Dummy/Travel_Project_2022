import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class GetHotelImages extends UseCase<List<PlatformFile>, ImagesParamss> {
  final HotelRepositories repository;

  GetHotelImages({required this.repository});

  @override
  Future<Either<Failures, List<PlatformFile>>> call(ImagesParamss params) {
    return repository.getHotelImage(params.name);
  }
}

class ImagesParamss {
  String name;
  ImagesParamss(this.name);
}
