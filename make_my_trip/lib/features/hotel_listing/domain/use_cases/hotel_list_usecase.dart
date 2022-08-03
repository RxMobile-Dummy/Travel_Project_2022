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
    return await hotelListRepository.getHotelList(
        params.cin, params.cout, params.noOfRoom, params.id, params.type);
  }
}

class Params {
  final String cin;
  final String cout;
  final int noOfRoom;
  final int id;
  final String type;

  Params(this.cin, this.cout, this.noOfRoom, this.id, this.type);
}
