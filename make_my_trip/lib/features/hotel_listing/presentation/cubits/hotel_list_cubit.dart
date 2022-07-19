import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_state.dart';
import 'package:meta/meta.dart';



class HotelListCubit extends Cubit<HotelListState> {
  HotelListCubit({required this.hotelListUsecase})
      : super(HotelListInitial()) {}
  final HotelListUsecase hotelListUsecase;

  // Future<List<HotelListModel>?> getHotelListApi(String s) async {
  //   await hotellistUsecase.call(s).then((value) =>
  //       value.fold((l) => print(l), (r) => emit(GetData(GetList: r))));
  // }

  getHotelListApi(String hotelName) async {
    var hotelListData = await hotelListUsecase.call(Params(hotelName));
    hotelListData.fold((l) => {print(l)}, (r) => emit(GetData(GetList: r)));

  }
}
