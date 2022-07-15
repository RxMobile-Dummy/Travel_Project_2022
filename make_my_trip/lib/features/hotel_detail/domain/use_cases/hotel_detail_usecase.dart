import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import '../../data/model/hotel_detail_model.dart';

class HotelDetailUseCase implements Usecase<HotelDetailModel, Params> {
  final HotelDetailRepository hotelDetailRepository;
  HotelDetailUseCase(this.hotelDetailRepository);
  @override
  Future<Either<Failures, HotelDetailModel>> call(Params params) async {
    return await hotelDetailRepository.getHotelDetails(params.index);
  }
}

class Params extends Equatable {
  final int index;

  Params({required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
