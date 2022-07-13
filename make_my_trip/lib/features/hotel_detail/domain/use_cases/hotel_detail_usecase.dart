import 'package:dartz/dartz.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';
import '../../data/model/hotel_detail_model.dart';

class HotelDetailUseCase implements Usecase<HotelDetailModel, int> {
  final HotelDetailRepository hotelDetailRepository;
  HotelDetailUseCase(this.hotelDetailRepository);
  @override
  Future<Either<Failures, HotelDetailModel>> call(int index) async {
    print('usecase');
    return await hotelDetailRepository.getHotelDetails(index);
  }
}
