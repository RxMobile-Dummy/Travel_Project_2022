import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/data_sources/hotel_data_source.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_post_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_put_model.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';

import 'package:flutter_isolate/flutter_isolate.dart';

class HotelDataSourceImpl implements HotelDataSource {
  final Dio dio;

  HotelDataSourceImpl({required this.dio});

  Future<List<String>> uploadUrl(
      List<PlatformFile> imageFileList, String firebaseReviewFolderName) async {
    List<String> imageUrl = [];
    for (var e in imageFileList) {
      try {
        final path = "${firebaseReviewFolderName}image${e.name}";
        final snapshot = await FirebaseStorage.instance
            .ref()
            .child(path)
            .putData(e.bytes!,
                SettableMetadata(contentType: 'image/${e.extension}'));
        if (snapshot != null) {
          imageUrl.add(await snapshot.ref.getDownloadURL());
        }
      } catch (e) {}
    }
    return imageUrl;
  }

  @override
  Future<Either<Failures, void>> postHotel(hotelImages, superDeluxImage,
      semiDeluImage, DeluxImage, HotelPostModel hotel) async {
    try {
      List<String> hotelImageString = [];
      List<String> semiImageString = [];
      List<String> superImageString = [];
      List<String> deluxImageString = [];

      hotelImageString.addAll(await uploadUrl(hotelImages, 'hotel/'));
      hotel.hotelimages = hotelImageString;
      semiImageString.addAll(await uploadUrl(semiDeluImage, 'semi_room/'));
      superImageString.addAll(await uploadUrl(superDeluxImage, 'super_room/'));
      deluxImageString.addAll(await uploadUrl(DeluxImage, 'deluxe_room/'));

      hotel.deluxeimages = deluxImageString;
      hotel.semideluxeimages = semiImageString;
      hotel.superdeluxeimages = superImageString;
      hotel.hotelimages = hotelImageString;

      Response response = await dio.post('${BaseConstant.baseUrl}hotel/addhotel',
          data: hotel.toJson(), options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Hotel Add Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: MakeMyTripColors.colorRed,
            textColor: MakeMyTripColors.colorWhite,
            fontSize: 16.0);
        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<HotelModels>>> getHotel(int page) async {
    try {
      var params = {"pagesize": 50, "page": page};

      final response = await dio.get('${BaseConstant.baseUrl}hotel/',
          queryParameters: params,
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        final List<HotelModels> hotelList = [];
        for (var item in response.data) {
          hotelList.add(HotelModels.fromJson(item));
        }
        return Right(hotelList);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteHotel(String id) async {
    try {
      final baseurl =
          '${BaseConstant.baseUrl}/hotel/deletehotel/${int.parse(id)}';
      final response = await dio.delete(baseurl,
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, HotelPutModel>> getHotelUpdate(String id) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}/hotel/updatehoteldata/${int.parse(id)}',
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        final HotelPutModel jsonList = HotelPutModel.fromJson(response.data);
        return Right(jsonList);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> updateHotel(
      HotelPutModel hotelPutModel) async {
    try {
      final response = await dio.put(
          '${BaseConstant.baseUrl}/hotel/updatehotel',
          data: hotelPutModel.toJson(),
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Updated Data Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: MakeMyTripColors.colorRed,
            textColor: MakeMyTripColors.colorWhite,
            fontSize: 16.0);

        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure(failureMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> hotelImages(String path) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg']);
      if (result != null) {
        PlatformFile file = result.files.first;
        final webImage = file.bytes;
        final imagePath = file.name;
        final ref = FirebaseStorage.instance.ref().child('$path/$imagePath');
        await ref.putData(webImage!);
        return const Right(null);
      } else {
        return const Right(null);
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<PlatformFile>>> getHotelImage(
      String path) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
          allowMultiple: true);
      if (result != null) {
        List<PlatformFile> files = result.files;
        return Right(files);
      } else {
        return const Right([]);
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
