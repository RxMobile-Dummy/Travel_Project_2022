import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../models/HotelModels.dart';

abstract class HotelDataRourceRepositories {
  Future<Either<Failures, void>> postHotel(Hotel hotel);
  Future<Either<Failures, List<HotelModels>>> getHotel();
  Future<Either<Failures,void>> deleteHotel(String id);

  Future<Either<Failures,HotelPutModel>> getHotelUpdate(String id);
  Future<Either<Failures,void>> updateHotel(HotelPutModel hotelPutModel);
}

class HotelDataSourceRepositoriesImpl implements HotelDataRourceRepositories {
  late Dio dio;
  var token1 =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFkMWIxOWYwZjU4ZTJjOWE5Njc3M2M5MmNmODA0NDEwMTc5NzEzMjMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWRtaW4iLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjYwODExNDkzLCJ1c2VyX2lkIjoiZHdra2Y1cTd1Zk9lWkNTcW81cU1CUjFzQTFGMiIsInN1YiI6ImR3a2tmNXE3dWZPZVpDU3FvNXFNQlIxc0ExRjIiLCJpYXQiOjE2NjA4MTE0OTQsImV4cCI6MTY2MDgxNTA5NCwiZW1haWwiOiJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.lgnFqYwFOmvnWqsO1Lkf3MA2iAiwMycYZyqPdhTGpu-p65AFcrO6WNOUaNOS_dAwjlJw5DVc_tnAqINe9S3wbp1vlDuTX6PlWDwWnV8CDhmeWhwR9tEqXmTFq5W9k473d0VHyuOYp2dcJc9chgTduGLui64qgc8DMVTjDJy8Z7eVffRQK2vSgHKUsrMRx-YhYyT3vkowJDQS8voBDUGDf28qbSTLnV6NLIGMNO0yfDEJbP1oWULWVlgqr68cAdMuULCAnR3o5DXhRspF6ysbzqT6wPxR7epWlzvtEBxrcW8Snz033Qapz3PqYVslw2bew1hEon0fNK206Kn-RqK7yQ";

  HotelDataSourceRepositoriesImpl({required this.dio});

  @override
  Future<Either<Failures, void>> postHotel(Hotel hotel) async {
    try {
      Response response =
          await dio.post('http://192.168.102.79:4000/hotel/addhotel', data: hotel);
      if (response.statusCode == 200) {
        print('success');
        return Right(null);
      } else {
        print('fail');
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<HotelModels>>> getHotel() async {
    try {
      final baseurl = 'http://192.168.102.79:4000/hotel';
      print(baseurl);
      final response = await dio.get('http://192.168.102.79:4000/hotel');
      if (response.statusCode == 200) {
        print("success");
        final List<HotelModels> hotelList = [];
        final jsonList = response.data;
        for (var item in jsonList) {
          hotelList.add(HotelModels.fromJson(item));
        }
        print(hotelList);
        print('hotel');
        return right(hotelList);
      } else {
        print("fail");
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteHotel(String id) async{
    // TODO: implement deleteHotel
    try {
      final baseurl = 'http://192.168.102.79:4000/hotel/deletehotel/${int.parse(id)}';
      print(baseurl);
      final response = await dio.delete(baseurl);
      if (response.statusCode == 200) {
           print("success");
           return Right(null);
        }
     else {
        print("fail");
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, HotelPutModel>> getHotelUpdate(String id) async{
    // TODO: implement getHotelUpdate
    try {
      final response = await dio.get('http://192.168.102.79:4000/hotel/updatehoteldata/${int.parse(id)}');
      if (response.statusCode == 200) {
        print("success");
        final HotelPutModel jsonList = HotelPutModel.fromJson(response.data);

        print(jsonList);
        print('data finded success');

        return Right(jsonList);
      } else {
        print("fail");
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateHotel(HotelPutModel hotelPutModel)async{
    try {
      final response = await dio.put('http://192.168.102.79:4000/hotel/updatehotel',data: hotelPutModel.toJson());
      print(hotelPutModel.toJson());
      print(response.statusCode);
      if (response.statusCode == 200) {

        print('data Update success');

        return Right(null);
      } else {

        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }
}
