import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../data/models/ToursModel.dart';

abstract class ToursRepository {
  Future<Either<Failures,List<ToursModel>>> get_tours();
}
