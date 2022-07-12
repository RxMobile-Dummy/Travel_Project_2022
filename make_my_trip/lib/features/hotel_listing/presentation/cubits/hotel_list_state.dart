part of 'hotel_list_cubit.dart';

@immutable
abstract class HotelListState {}

class HotelListInitial extends HotelListState {}

class GetData extends HotelListState {
  List<HotelListModel> GetList;

  GetData({required this.GetList});

  @override
  List<Object> get props => [];
}
