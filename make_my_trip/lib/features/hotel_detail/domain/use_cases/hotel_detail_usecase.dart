import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import '../../data/model/hotel_detail_model.dart';

class HotelDetailUseCase
    implements Usecase<HotelDetailModel, HotelDetailParams> {
  final HotelDetailRepository hotelDetailRepository;
  HotelDetailUseCase(this.hotelDetailRepository);
  @override
  Future<Either<Failures, HotelDetailModel>> call(
      HotelDetailParams params) async {
    return await hotelDetailRepository.getHotelDetails(params.index);
  }
}

class HotelDetailParams extends Equatable {
  final int index;

  const HotelDetailParams({required this.index});

  @override
  List<Object?> get props => [index];
}
