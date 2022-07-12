import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_list_repository.dart';

class Hotellist_usercase {
  final Hotel_List_Repository hotel_list_repository;

  Hotellist_usercase({required this.hotel_list_repository});

  call(String s) {
    return hotel_list_repository.get_hotel_list(s);
  }
}
