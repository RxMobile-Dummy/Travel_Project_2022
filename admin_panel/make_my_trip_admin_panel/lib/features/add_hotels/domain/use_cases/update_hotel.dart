
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/domain/repositories/hotel_repositories.dart';

class UpdateHotel extends UseCase<void, UpdateHotelParams> {
  final HotelRepositories repository;

  UpdateHotel({required this.repository});

  @override
  Future<Either<Failures, void>> call(UpdateHotelParams params) async {
    return await repository.updateHotel(params.hotelPutModel,
    params.deluxeImages,params.semiDeluxeImages,params.superDeluxeImages,params.hotelPutModel);
  }

}
class UpdateHotelParams {
  final  HotelPutModel hotelPutModel;
  final  List<PlatformFile> hotelImages;
  final  List<PlatformFile> deluxeImages;
  final  List<PlatformFile> semiDeluxeImages;
  final  List<PlatformFile> superDeluxeImages;

  UpdateHotelParams(this.hotelPutModel, this.hotelImages, this.deluxeImages,
      this.semiDeluxeImages, this.superDeluxeImages);
}
