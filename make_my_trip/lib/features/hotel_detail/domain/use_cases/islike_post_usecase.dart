import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/repositories/hotel_detail_repository.dart';

class IsLikePostUseCase implements Usecase<void, IsLikePostParams> {
  final HotelDetailRepository hotelDetailRepository;
  IsLikePostUseCase(this.hotelDetailRepository);
  @override
  Future<Either<Failures, void>> call(IsLikePostParams params) async {
    return await hotelDetailRepository.postIsLike(params.index);
  }
}

class IsLikePostParams extends Equatable {
  final int index;

  const IsLikePostParams({required this.index});

  @override
  List<Object?> get props => [index];
}
