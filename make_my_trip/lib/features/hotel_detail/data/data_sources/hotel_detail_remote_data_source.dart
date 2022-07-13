import 'package:dio/dio.dart';
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
    try {
      print('DataSource');
      final baseurl = 'http://192.168.101.124:4000/hotel/${index}';

      final response = await dio.get(baseurl);
      print(response.data);
      if (response.statusCode == 200) {
        final HotelDetailModel hotelDetailModel = response.data[0];
        print(hotelDetailModel.hotelName);
        return hotelDetailModel;
      } else if (response.statusCode == 505) {
        throw ServerFailure();
      } else if (response.statusCode == 404) {
        throw AuthFailure(); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        throw InternetFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }
}
