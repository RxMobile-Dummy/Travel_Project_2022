import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_list_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/hotel_list_model.dart';

class HotelListUsecase implements Usecase<List<HotelListModel>, Params> {
  final HotelListRepository hotelListRepository;

  HotelListUsecase(this.hotelListRepository);

  @override
  Future<Either<Failures, List<HotelListModel>>> call(Params params) async {
    return await hotelListRepository.getHotelList(params.hotelName);
  }
}

class Params {
  final String hotelName;
  Params(this.hotelName);
}
