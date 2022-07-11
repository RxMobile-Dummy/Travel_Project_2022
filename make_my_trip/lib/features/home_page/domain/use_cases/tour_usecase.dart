import 'package:make_my_trip/features/home_page/domain/repositories/tours_repository.dart';

class Tours_usecase {
  final ToursRepository toursRepository;

  Tours_usecase({required this.toursRepository});

  call(Map map) {
    return toursRepository.get_tours();
  }
}
