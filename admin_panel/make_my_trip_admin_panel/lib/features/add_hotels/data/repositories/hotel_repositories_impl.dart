import 'package:dartz/dartz.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_dataSource_repositories.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class HotelRepositoriesImpl implements HotelRepositories {
  late HotelDataRourceRepositories repositories;

  HotelRepositoriesImpl({required this.repositories});

  @override
  Future<Either<Failures, void>> postEmployee(hotel) {
    return repositories.postEmployee(hotel);
  }

  @override
  Future<Either<Failures, List<HotelModels>>> getHotel() {
    // TODO: implement getHotel
    return repositories.getHotel();
  }
}
