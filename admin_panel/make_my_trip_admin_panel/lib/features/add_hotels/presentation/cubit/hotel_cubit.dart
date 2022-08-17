import 'package:bloc/bloc.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/use_cases/add_hotel.dart';
import 'package:meta/meta.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  PostHotel postHotel;
  HotelCubit({required this.postHotel}) : super(HotelInitial());

}
