import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';

abstract class HotelDataRourceRepositories{
  Future<Either<Failures,void>> postEmployee(Hotel hotel);
}

class HotelDataSourceRepositoriesImpl extends HotelDataRourceRepositories{
  late Dio dio;

  HotelDataSourceRepositoriesImpl({required this.dio});

  @override
  Future<Either<Failures, void>> postEmployee(Hotel hotel) async{
    // TODO: implement postEmployee
    Hotel? hotelData;
    print(hotel.hotel_name);
    try{
      String url = "http://192.168.102.60:9006/hotel/addhotel";
      Response response = await dio.post(
        url,
        data: hotel.toJson(),
      );
      print(response.data);
      hotelData = Hotel.fromJson(response.data);
    }
    catch (e){
      // print(e);
      throw e;
    }
    print(hotelData);
    return Right(hotelData);
  }
}