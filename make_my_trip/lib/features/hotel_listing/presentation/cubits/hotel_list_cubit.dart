import 'package:bloc/bloc.dart';
import 'package:make_my_trip/features/hotel_listing/domain/use_cases/hotel_list_usecase.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_state.dart';

class HotelListCubit extends Cubit<HotelListState> {
  HotelListCubit({required this.hotelListUsecase}) : super(HotelListInitial());
  final HotelListUsecase hotelListUsecase;

  getHotelListApi(String hotelName) async {
    print(hotelName);
    var hotelListData = await hotelListUsecase.call(Params(hotelName));
    hotelListData.fold((l) => {print(l)}, (r) => emit(GetData(GetList: r)));
  }
}
