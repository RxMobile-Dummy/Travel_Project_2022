import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';

abstract class HotelDetailRemoteDataSource {
  Future<HotelDetailModel> getAllHotelDetailData(int index);
}

class HotelDetailRemoteDataSourceImpl implements HotelDetailRemoteDataSource {
  final Dio dio;
  HotelDetailRemoteDataSourceImpl(this.dio);

  @override
  Future<HotelDetailModel> getAllHotelDetailData(int index) async {
    return _getAllCharacterUrl('http://192.168.101.124:4000/hotel/${index}');
  }

  Future<HotelDetailModel> _getAllCharacterUrl(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      HotelDetailModel hotelDetailModel;
      final apidata = response.data;
      hotelDetailModel = HotelDetailModel.fromJson(apidata);

      return hotelDetailModel;
    } else {
      throw ServerFailure();
    }
  }
}
