import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';

class IsLikeDeleteUseCase implements Usecase<void, IsLikeDeleteParams> {
  final HotelDetailRepository hotelDetailRepository;
  IsLikeDeleteUseCase(this.hotelDetailRepository);
  @override
  Future<Either<Failures, void>> call(IsLikeDeleteParams params) async {
    return await hotelDetailRepository.deleteIsLike(params.index);
  }
}

class IsLikeDeleteParams extends Equatable {
  final int index;

  const IsLikeDeleteParams({required this.index});

  @override
  List<Object?> get props => [index];
}
