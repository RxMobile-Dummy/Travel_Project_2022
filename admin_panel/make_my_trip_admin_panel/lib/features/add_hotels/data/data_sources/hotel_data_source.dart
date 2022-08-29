import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_put_model.dart';

import '../models/hotel_model.dart';
import '../models/hotel_post_model.dart';

abstract class HotelDataSource {
  Future<Either<Failures, void>> postHotel(hotelImages, superDeluxImage,
      semiDeluxImage, deluxImage, HotelPostModel hotel);

  Future<Either<Failures, List<HotelModels>>> getHotel(int page);

  Future<Either<Failures, void>> deleteHotel(String id);

  Future<Either<Failures, HotelPutModel>> getHotelUpdate(String id);

  Future<Either<Failures, void>> updateHotel(HotelPutModel hotelPutModel);

  Future<Either<Failures, void>> hotelImages(String path);

  Future<Either<Failures, List<PlatformFile>>> getHotelImage(String path);
}
