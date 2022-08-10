import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/book_cubit.dart';

var bookingSl = GetIt.instance;

Future<void> init() async {
  //cubit
  bookingSl.registerFactory(() => BookingCubit(bookingSl(), bookingSl()));
}
