import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_data_source.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_put_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class HotelRepositoriesImpl implements HotelRepositories {
  final HotelDataSource repositories;

  HotelRepositoriesImpl({required this.repositories});

  @override
  Future<Either<Failures, void>> postHotel(
      hotelImages, superDeluxImage, semiDeluxImage, deluxImage, hotel) {
    return repositories.postHotel(
        hotelImages, superDeluxImage, semiDeluxImage, deluxImage, hotel);
  }

  @override
  Future<Either<Failures, List<HotelModels>>> getHotel(int page) {
    return repositories.getHotel(page);
  }

  @override
  Future<Either<Failures, void>> deleteHotel(String id) {
    return repositories.deleteHotel(id);
  }

  @override
  Future<Either<Failures, void>> updateHotel(HotelPutModel hotelPutModel) {
    return repositories.updateHotel(hotelPutModel);
  }

  @override
  Future<Either<Failures, HotelPutModel>> getHotelUpdate(String id) {
    return repositories.getHotelUpdate(id);
  }

  @override
  Future<Either<Failures, void>> hotelImages(String path) {
    return repositories.hotelImages(path);
  }

  @override
  Future<Either<Failures, List<PlatformFile>>> getHotelImage(String path) {
    return repositories.getHotelImage(path);
  }
}
