import '../../data/models/hotel_list_model.dart';

abstract class HotelListState {}

class HotelListInitial extends HotelListState {}

class GetData extends HotelListState {
  List<HotelListModel> GetList;

  GetData({required this.GetList});

  @override
  List<Object> get props => [];
}
