import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/tours_datasource.dart';
import 'package:make_my_trip/features/home_page/domain/repositories/tours_repository.dart';
import '../../../../core/failures/failures.dart';
import '../models/ToursModel.dart';

class ToursRepositoryImpl extends ToursRepository {
  ToursDataSource toursDataSource;

  ToursRepositoryImpl({required this.toursDataSource});

  @override
  Future<Either<Failures, List<ToursModel>>> getTours() async {
    print('ToursRepositoryImpl 4');
    var reponse = await toursDataSource.getToursData();
    return reponse;
  }
}
