import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

import '../../data/models/hotel_post_model.dart';

class PostHotel extends UseCase<void, AddHotelParams> {
  final HotelRepositories repository;

  PostHotel({required this.repository});

  @override
  Future<Either<Failures, void>> call(AddHotelParams params) async {
    return await repository.postHotel(
      params.hotelImages,
      params.superDeluxeImages,
      params.semiDeluxeImages,
      params.deluxeImages,
      params.hotelPostModel,
    );
  }
}

class AddHotelParams {
  final HotelPostModel hotelPostModel;
  final List<PlatformFile> hotelImages;
  final List<PlatformFile> deluxeImages;
  final List<PlatformFile> semiDeluxeImages;
  final List<PlatformFile> superDeluxeImages;

  AddHotelParams(this.hotelPostModel, this.deluxeImages, this.semiDeluxeImages,
      this.superDeluxeImages, this.hotelImages);
}
