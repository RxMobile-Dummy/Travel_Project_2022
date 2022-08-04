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
    return await hotelListRepository.getHotelList(params);
  }
}

class Params {
  final String cin;
  final String cout;
  final int noOfRoom;
  final int id;
  final String type;
  final String? aminities;
  final String? price;
  final String? rating;
  Params(
      {this.aminities,
      this.price,
      this.rating,
      required this.cin,
      required this.cout,
      required this.noOfRoom,
      required this.id,
      required this.type});
}
