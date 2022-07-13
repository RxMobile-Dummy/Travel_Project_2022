import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_list_repository.dart';

import '../../data/models/hotel_list_model.dart';

class Hotellist_usercase<Type, Params> {
  final Hotel_List_Repository hotel_list_repository;

  Hotellist_usercase({required this.hotel_list_repository});

  Future<Either<Failures,List<HotelListModel>>> call(String s) {
    return hotel_list_repository.get_hotel_list(s);
  }
}
//
// abstract class UseCase<Type, Params> {
//   Future<Either<Failure, Type>?>?call(Params params);
// }
//
// class NoParams extends Equatable {
//   @override
//   List<Object?> get props => [];
// }