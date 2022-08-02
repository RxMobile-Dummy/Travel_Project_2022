import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_detail/data/data_sources/hotel_detail_remote_data_source.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';

class HotelDetailRepositoryImpl implements HotelDetailRepository {
  final HotelDetailRemoteDataSource hotelDetailRemoteDataSource;
  HotelDetailRepositoryImpl(this.hotelDetailRemoteDataSource);

  @override
  Future<Either<Failures, HotelDetailModel>> getHotelDetails(int index) async {
    return await hotelDetailRemoteDataSource.getAllHotelDetailData(index);
  }

  @override
  Future<Either<Failures, void>> deleteIsLike(int hotelId) async {
    return await hotelDetailRemoteDataSource.deleteIsLikeData(hotelId);
  }

  @override
  Future<Either<Failures, void>> postIsLike(int hotelId) async {
    return await hotelDetailRemoteDataSource.postIsLikeData(hotelId);
  }
}
