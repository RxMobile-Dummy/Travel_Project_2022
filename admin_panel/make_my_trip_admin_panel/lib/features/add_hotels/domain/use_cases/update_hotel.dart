import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_put_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class UpdateHotel extends UseCase<void, HotelPutModel> {
  final HotelRepositories repository;

  UpdateHotel({required this.repository});

  @override
  Future<Either<Failures, void>> call(HotelPutModel hotelPutModel) async {
    return await repository.updateHotel(hotelPutModel);
  }
}
