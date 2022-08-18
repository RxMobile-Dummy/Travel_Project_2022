import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class GetAllHotel extends UseCase<List<HotelModels>,NoParams>{
  final HotelRepositories repository;

  GetAllHotel({required this.repository});

  @override
  Future<Either<Failures, List<HotelModels>>> call(NoParams params) {
    // TODO: implement call
      return repository.getHotel();
  }
}