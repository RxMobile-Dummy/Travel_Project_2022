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
    try {
      print('repo impl');
      return Right(
          await hotelDetailRemoteDataSource.getAllHotelDetailData(index));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
