import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../models/HotelModels.dart';

abstract class HotelDataRourceRepositories {
  Future<Either<Failures, void>> postEmployee(Hotel hotel);

  Future<Either<Failures, List<HotelModels>>> getHotel();
}

class HotelDataSourceRepositoriesImpl implements HotelDataRourceRepositories {
  late Dio dio;
  var token1 =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFkMWIxOWYwZjU4ZTJjOWE5Njc3M2M5MmNmODA0NDEwMTc5NzEzMjMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWRtaW4iLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjYwODExNDkzLCJ1c2VyX2lkIjoiZHdra2Y1cTd1Zk9lWkNTcW81cU1CUjFzQTFGMiIsInN1YiI6ImR3a2tmNXE3dWZPZVpDU3FvNXFNQlIxc0ExRjIiLCJpYXQiOjE2NjA4MTE0OTQsImV4cCI6MTY2MDgxNTA5NCwiZW1haWwiOiJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.lgnFqYwFOmvnWqsO1Lkf3MA2iAiwMycYZyqPdhTGpu-p65AFcrO6WNOUaNOS_dAwjlJw5DVc_tnAqINe9S3wbp1vlDuTX6PlWDwWnV8CDhmeWhwR9tEqXmTFq5W9k473d0VHyuOYp2dcJc9chgTduGLui64qgc8DMVTjDJy8Z7eVffRQK2vSgHKUsrMRx-YhYyT3vkowJDQS8voBDUGDf28qbSTLnV6NLIGMNO0yfDEJbP1oWULWVlgqr68cAdMuULCAnR3o5DXhRspF6ysbzqT6wPxR7epWlzvtEBxrcW8Snz033Qapz3PqYVslw2bew1hEon0fNK206Kn-RqK7yQ";

  HotelDataSourceRepositoriesImpl({required this.dio});

  @override
  Future<Either<Failures, void>> postEmployee(Hotel hotel) async {
    try {
      Response response =
          await dio.post('${BaseConstant.baseUrl}hotel/addhotel', data: hotel);
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
      final baseurl = '${BaseConstant.baseUrl}hotel/';
      print(baseurl);
      final response = await dio.get(baseurl);
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
}
