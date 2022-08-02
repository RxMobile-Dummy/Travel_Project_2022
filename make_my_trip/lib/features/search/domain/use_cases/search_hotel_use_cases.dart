import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/search_hotel_model.dart';
import '../repositories/search_hotel_repository.dart';

class SearchHotelUseCases implements Usecase<List<SearchHotelModel>, String> {
  final SearchHotelRepository searchHotelRepository;

  SearchHotelUseCases(this.searchHotelRepository);

  @override
  Future<Either<Failures, List<SearchHotelModel>>> call(String places) async {
    return await searchHotelRepository.getNearByPlacesList(places);
  }
}
