

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';

import '../../../../../core/failures/failures.dart';
import '../../models/hotel_list_model.dart';




class HotelListDataSourceImpl implements HotelListDataSource {
  final Dio dio;

  HotelListDataSourceImpl(this.dio);
  @override
  Future<Either<Failures, List<HotelListModel>>> getHotelListData(String hotelName) async{
    try {
     final baseurl  = 'http://192.168.102.79:4000/hotel/${hotelName}';

     print(baseurl);
     final response = await dio.get(baseurl);
     print("This is response ${response}");
     print(response.statusCode);
     if (response.statusCode == 200) {

       final List<HotelListModel> hotelList = [];
       final jsonList = response.data;
       for (var item in jsonList) {
         hotelList.add(HotelListModel.fromJson(item));
       }
       return right(hotelList);

     } else if (response.statusCode == 505) {
       return Left( ServerFailure());
     } else if (response.statusCode == 404) {
      return Left(AuthFailure()); //Data Not Found Failure but in failure there is not method so AuthFailure
     } else {
       return Left(InternetFailure());
     }

    }catch (e) {
      print("server");
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
  
}