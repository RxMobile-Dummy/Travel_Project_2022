import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';

import '../../../../../core/failures/failures.dart';
import '../../models/hotel_list_model.dart';
//
// class HotelListDataSourceImpl extends HotelListDataSource {
//   Future<Either<Failures, List<HotelListModel>>> getHotelList(
//       String s) async {
//     try {
//       final response =
//           await http.get(Uri.parse('http://192.168.101.164:4000/hotel/${s}'));
//       var data = jsonDecode(response.body.toString());
//       List<HotelListModel> postlist = [];
//       {
//         for (Map i in data) {
//           postlist.add(HotelListModel.fromJson(i));
//         }
//         return Right(postlist);
//       }
//     } catch (e) {
//       return Left(ServerFailure(failureMsg: e.toString()));
//     }
//   }
// }



class HotelListDataSourceImpl implements HotelListDataSource {
  final Dio dio;

  HotelListDataSourceImpl(this.dio);
  @override
  Future<Either<Failures, List<HotelListModel>>> getHotelListData(String hotelName) async{
    try {
     final baseurl  = 'http://192.168.102.79:4000/hotel/${hotelName}' ;
     final response = await dio.get(baseurl);
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
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
  
}