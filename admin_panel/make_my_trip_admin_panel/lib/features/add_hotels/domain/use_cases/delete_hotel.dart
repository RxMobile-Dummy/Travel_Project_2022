
import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class DeleteHotel extends UseCase<void, String> {
  final HotelRepositories repository;

  DeleteHotel({required this.repository});

  @override
  Future<Either<Failures, void>> call(String id) {
      return repository.deleteHotel(id);
  }
}
