import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_list_datasource.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/repositories/hotel_list_repository.dart';
import '../models/hotel_list_model.dart';

class HotelListRepositoryImpl implements HotelListRepository {
  final HotelListDataSource hotelListDataSource;

  HotelListRepositoryImpl({required this.hotelListDataSource});

  @override
  Future<Either<Failures, List<HotelListModel>>> getHotelList(String hotelName) async {
   return await hotelListDataSource.getHotelListData(hotelName);
  }


}
