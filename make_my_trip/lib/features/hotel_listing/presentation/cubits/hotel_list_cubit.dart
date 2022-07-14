import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../core/failures/failures.dart';

part 'hotel_list_state.dart';

class HotelListCubit extends Cubit<HotelListState> {
  HotelListCubit({required this.hotellist_usecase})
      : super(HotelListInitial()) {}
  final Hotellist_Usecase hotellist_usecase;

  Future<List<HotelListModel>?> get_hotel_list_api(String s) async {
    await hotellist_usecase.call(s).then((value) =>
        value.fold((l) => print(l), (r) => emit(GetData(GetList: r))));
  }
}
