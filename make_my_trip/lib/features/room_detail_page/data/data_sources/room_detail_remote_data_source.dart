import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';

abstract class RoomDetailRemoteDataSource {
  Future<RoomDetailsModel> getRoomDetailData (int hotelId,String roomType );
}


class RoomDetailDataSourceImpl implements RoomDetailRemoteDataSource{
  final Dio dio;

  RoomDetailDataSourceImpl(this.dio);
  @override
  Future<RoomDetailsModel> getRoomDetailData (int hotelId, String roomType) async {
    try{
      print('data source');
      final baseurl = 'http://192.168.102.79:3000/room/${hotelId}/${roomType}';
      final response = await dio.get(baseurl);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {

        final RoomDetailsModel roomDetailsModel =  RoomDetailsModel.fromJson(response.data);

        return roomDetailsModel;
      } else if (response.statusCode == 505) {
        throw ServerFailure();
      } else if (response.statusCode == 404) {
        throw AuthFailure(); //Data Not Found Failure but in failure there is not method so AuthFailure
      } else {
        throw InternetFailure();
      }
    }catch (e) {
      throw ServerFailure();
    }

  }
}