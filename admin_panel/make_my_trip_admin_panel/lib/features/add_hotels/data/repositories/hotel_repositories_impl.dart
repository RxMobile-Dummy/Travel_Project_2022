import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_dataSource_repositories.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class HotelRepositoriesImpl implements HotelRepositories {
  late HotelDataRourceRepositories repositories;

  HotelRepositoriesImpl({required this.repositories});

  @override
  Future<Either<Failures, void>> postHotel(hotelImages,
      superDeluxImage,
      semiDeluImage,
      DeluxImage,hotel) {
    return repositories.postHotel(hotelImages,
        superDeluxImage,
        semiDeluImage,
        DeluxImage,hotel);
  }

  @override
  Future<Either<Failures, List<HotelModels>>> getHotel(int page) {
    // TODO: implement getHotel
    return repositories.getHotel(page);
  }

  @override
  Future<Either<Failures, void>> deleteHotel(String id) {
    // TODO: implement deleteHotel
    return repositories.deleteHotel(id);
  }

  @override
  Future<Either<Failures, void>> updateHotel(hotelImages,
      superDeluxeImage,
      semiDeluxeImage,
      deluxeImage,hotelPutModel) {
    // TODO: implement updateHotel
    return repositories.updateHotel(hotelImages,
        superDeluxeImage,
        semiDeluxeImage,
        deluxeImage,hotelPutModel);
  }

  @override
  Future<Either<Failures, HotelPutModel>> getHotelUpdate(String id) {
    // TODO: implement getHotelUpdate
    return repositories.getHotelUpdate(id);
  }

  @override
  Future<Either<Failures, void>> hotelImages(String path) {
    // TODO: implement hotelImages
    return repositories.hotelImages(path);
  }

  @override
  Future<Either<Failures, List<PlatformFile>>> getHotelImage(String path) {
    // TODO: implement getHotelImage
    return repositories.getHotelImage(path);
  }

}
