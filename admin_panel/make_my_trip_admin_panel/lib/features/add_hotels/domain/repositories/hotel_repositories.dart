import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';

abstract class HotelRepositories{
  Future<Either<Failures,void>> postHotel(Hotel hotel);
  Future<Either<Failures, List<HotelModels>>> getHotel();
  Future<Either<Failures,void>> deleteHotel(String id);
  Future<Either<Failures,HotelPutModel>> getHotelUpdate(String id);
  Future<Either<Failures,void>> updateHotel(HotelPutModel hotelPutModel);
}