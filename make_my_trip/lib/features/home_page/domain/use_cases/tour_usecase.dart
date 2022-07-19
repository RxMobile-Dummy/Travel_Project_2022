import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/tours_repository.dart';

import '../../../../core/failures/failures.dart';

class GetAllToursOfHomepageUseCase {
  final ToursRepository toursRepository;

  GetAllToursOfHomepageUseCase({required this.toursRepository});

  Future<Either<Failures, List<ToursModel>>> call() {
    return toursRepository.getTours();
  }
}
