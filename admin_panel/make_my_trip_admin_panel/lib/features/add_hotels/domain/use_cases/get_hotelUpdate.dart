import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_put_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class GetHotelPut extends UseCase<HotelPutModel, String> {
  final HotelRepositories repository;

  GetHotelPut({required this.repository});

  @override
  Future<Either<Failures, HotelPutModel>> call(String params) {
    return repository.getHotelUpdate(params);
  }
}
