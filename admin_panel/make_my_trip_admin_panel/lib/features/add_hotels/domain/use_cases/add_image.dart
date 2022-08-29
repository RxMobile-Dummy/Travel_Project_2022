import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class AddHotelImage extends UseCase<void, ImagesParams> {
  final HotelRepositories repository;

  AddHotelImage({required this.repository});

  @override
  Future<Either<Failures, void>> call(ImagesParams params) async {
    return await repository.hotelImages(params.name);
  }
}

class ImagesParams {
  String name;
  ImagesParams(this.name);
}
