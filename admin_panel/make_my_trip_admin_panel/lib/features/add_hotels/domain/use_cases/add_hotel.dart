
import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class PostHotel extends UseCase<void, Hotel> {
  final HotelRepositories repository;

  PostHotel({required this.repository});

  @override
  Future<Either<Failures,void>> call(Hotel hotel) async{

    return await repository.postEmployee(hotel);

  }
}
