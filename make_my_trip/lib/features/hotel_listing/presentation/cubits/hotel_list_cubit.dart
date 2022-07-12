import 'package:bloc/bloc.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:meta/meta.dart';

part 'hotel_list_state.dart';

class HotelListCubit extends Cubit<HotelListState> {
  HotelListCubit(this.hotellist_usercase) : super(HotelListInitial()) {}
  final Hotellist_usercase hotellist_usercase;

  get_hotel_list_api(String s) async {
    var data = await hotellist_usercase.call(s);
    emit(GetData(GetList: data));
    return await data;
  }
}