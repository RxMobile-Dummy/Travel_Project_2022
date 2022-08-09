import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/booking/domain/use_cases/booking_usecase.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/book_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/payment_integeration_cubit.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'data/data_sources/booking_remote_data_source.dart';
import 'data/repositories/booking_repository_impl.dart';
import 'domain/repositories/booking_repository.dart';
import 'domain/use_cases/payment_usecase.dart';

var bookingSl = GetIt.instance;

Future<void> init() async {
  final _razorpay = Razorpay();
  //cubit
  bookingSl.registerFactory(() => BookingCubit(bookingSl(), bookingSl()));

  bookingSl.registerFactory(() => PaymentCubit(bookingSl(), bookingSl(),bookingSl()));

  bookingSl.registerLazySingleton(() => _razorpay);

  //DataSource
  bookingSl.registerLazySingleton<BookingRemoteDataSource>(
      () => BookingRemoteDataSourceImpl(bookingSl()));

  //Repository
  bookingSl.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(bookingSl()));

  //usecase
  bookingSl.registerLazySingleton(() => PaymentUseCase(bookingSl()));
  bookingSl.registerLazySingleton(() => BookingUseCase(bookingSl()));
}
