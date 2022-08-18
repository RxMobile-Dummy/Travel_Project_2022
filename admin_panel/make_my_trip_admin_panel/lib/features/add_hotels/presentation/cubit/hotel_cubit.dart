import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_hotel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/get_hotel.dart';

class HotelCubit extends Cubit<BaseState> {
  PostHotel postHotel;
  GetAllHotel getHotel;

  HotelCubit({required this.postHotel,required this.getHotel}) : super(StateInitial());

  addHotels(
      double? latitude,
      double? logitude,
      String hotelname,
      int pincode,
      int city_id,
      String address_line,
      int rating,
      int price,
      int phonenumber,
      int no_rooms,
      String description,
      String deluxebadsize,
      String deluxedescription,
      List<String> deluxefeatures,
      int deluxemaxcapacity,
      int deluxeprice,
      String deluxesize,
      List<String> hotelFeatures,
      int no_of_room,
      int noodsuperdeluxe,
      int noofdeluxe,
      int noofsemideluxe,
      String semideluxebadsize,
      String semideluxedescription,
      List<String> semideluxefeatures,
      int semideluxemaxcapacity,
      int semideluxeprice,
      String semideluxesize,
      String superdeluxebadsize,
      String superdeluxedescription,
      List<String> superdeluxefeatures,
      int superdeluxemaxcapacity,
      int superdeluxeprice,
      String superdeluxesize) async {
    print("cubit called");
    var res = await postHotel.call(Hotel(
        address: Address(
            address_line: address_line,
            pincode: pincode,
            city_id: city_id,
            location: Location(latitude: latitude!, longitude: logitude!)),
        deluxebadsize: deluxebadsize,
        deluxedescription: deluxedescription,
        deluxefeatures: deluxefeatures,
        deluxemaxcapacity: deluxemaxcapacity,
        deluxeprice: deluxeprice,
        deluxesize: deluxesize,
        features: hotelFeatures,
        hotel_name: hotelname,
        no_of_room: no_of_room,
        noodsuperdeluxe: noodsuperdeluxe,
        noofdeluxe: noofdeluxe,
        noofsemideluxe: noofsemideluxe,
        phone_number: phonenumber,
        price: price,
        rating: rating,
        semideluxebadsize: semideluxebadsize,
        semideluxedescription: semideluxedescription,
        semideluxefeatures: semideluxefeatures,
        semideluxemaxcapacity: semideluxemaxcapacity,
        semideluxeprice: semideluxeprice,
        semideluxesize: semideluxesize,
        superdeluxebadsize: superdeluxebadsize,
        superdeluxedescription: superdeluxedescription,
        superdeluxefeatures: superdeluxefeatures,
        superdeluxemaxcapacity: superdeluxemaxcapacity,
        superdeluxeprice: superdeluxeprice,
        superdeluxesize: superdeluxesize,
        description: description));
    res.fold(
      (failure) {
        print("failure");
        emit(StateNoData());
      },
      (success) {
        print("success");
        emit(StateOnSuccess(success));
      },
    );
  }
  demo(String hotelname,int price,String address, List<String> semiDeluxeRoomFeatures) async{
      print(price);
      print(semiDeluxeRoomFeatures);
  }

  getHotels() async{
    var res = await getHotel.call(NoParams());
    res.fold((l) {
      print("failure");
      emit(StateErrorGeneral("errorMessage"));
      }, (r) {
        print("success");
        emit(StateOnSuccess<List<HotelModels>>(r));
    });
  }
}
