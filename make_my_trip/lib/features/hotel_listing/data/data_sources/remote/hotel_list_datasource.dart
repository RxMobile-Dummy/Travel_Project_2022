import 'package:dartz/dartz.dart';
import '../../../../../core/failures/failures.dart';
import '../../../domain/use_cases/hotel_list_usecase.dart';
import '../../models/hotel_list_model.dart';

abstract class HotelListDataSource {
  Future<Either<Failures, List<HotelListModel>>> getHotelListData(
      Params params);
}
