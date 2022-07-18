import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/tours_repository.dart';

import '../../../../core/failures/failures.dart';

class ToursUseCase {
  final ToursRepository toursRepository;

  ToursUseCase({required this.toursRepository});

  Future<Either<Failures, List<ToursModel>>> call() {
    print('ToursUseCase 3');
    return toursRepository.getTours();
  }
}
