import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';

abstract class HotelRepositories{
  Future<Either<Failures,void>> postEmployee(Hotel hotel);
  Future<Either<Failures, List<HotelModels>>> getHotel();
}