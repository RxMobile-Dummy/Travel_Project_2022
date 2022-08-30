import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelPutModel.dart';


import '../models/HotelModels.dart';
import '../models/HotelPostModel.dart';


abstract class HotelDataRourceRepositories {
  Future<Either<Failures, void>> postHotel(hotelImages,
      superDeluxeImage,
      semiDeluxeImage,
      deluxeImage,HotelPostModel hotel);

  Future<Either<Failures, List<HotelModels>>> getHotel(int page);

  Future<Either<Failures, void>> deleteHotel(String id);

  Future<Either<Failures, HotelPutModel>> getHotelUpdate(String id);

  Future<Either<Failures, void>> updateHotel(hotelImages,
      superDeluxImage,
      semiDeluImage,
      DeluxImage,HotelPutModel hotelPutModel);

  Future<Either<Failures, void>> hotelImages(String path);

  Future<Either<Failures, List<PlatformFile>>> getHotelImage(String path);
}

class HotelDataSourceRepositoriesImpl implements HotelDataRourceRepositories {
  late Dio dio;

  // var token1 =
  //     "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFkMWIxOWYwZjU4ZTJjOWE5Njc3M2M5MmNmODA0NDEwMTc5NzEzMjMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWRtaW4iLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjYwODExNDkzLCJ1c2VyX2lkIjoiZHdra2Y1cTd1Zk9lWkNTcW81cU1CUjFzQTFGMiIsInN1YiI6ImR3a2tmNXE3dWZPZVpDU3FvNXFNQlIxc0ExRjIiLCJpYXQiOjE2NjA4MTE0OTQsImV4cCI6MTY2MDgxNTA5NCwiZW1haWwiOiJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0cmF2ZWxzeWFkbWluQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.lgnFqYwFOmvnWqsO1Lkf3MA2iAiwMycYZyqPdhTGpu-p65AFcrO6WNOUaNOS_dAwjlJw5DVc_tnAqINe9S3wbp1vlDuTX6PlWDwWnV8CDhmeWhwR9tEqXmTFq5W9k473d0VHyuOYp2dcJc9chgTduGLui64qgc8DMVTjDJy8Z7eVffRQK2vSgHKUsrMRx-YhYyT3vkowJDQS8voBDUGDf28qbSTLnV6NLIGMNO0yfDEJbP1oWULWVlgqr68cAdMuULCAnR3o5DXhRspF6ysbzqT6wPxR7epWlzvtEBxrcW8Snz033Qapz3PqYVslw2bew1hEon0fNK206Kn-RqK7yQ";
  var baseUrl = "http://192.168.102.60:4000";

  HotelDataSourceRepositoriesImpl({required this.dio});

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }



  Future<List<String>> uploadUrl(List<PlatformFile> imageFileList,String firebaseReviewFolderName) async {
    List<String> imageUrl = [];
    for(var e in imageFileList){
      try {
      final path =
          firebaseReviewFolderName + "image" + e.name;
      // File file=File(e.path!);
      // final filename = e.path;
      final snapshot = await FirebaseStorage.instance.ref().child(path).putData(e.bytes!, SettableMetadata(contentType: 'image/${e.extension}'));
    if(snapshot!=null){
      imageUrl.add(await snapshot.ref.getDownloadURL());
      // print('uploaded success');
      // print(imageUrl);
    }
      } catch (e) {}
    }
    return imageUrl;
  }

  @override
  Future<Either<Failures, void>> postHotel(hotelImages,
      superDeluxImage,
      semiDeluImage,
      DeluxImage,HotelPostModel hotel) async {
    try {

      List<String> hotelImageString=[];
      List<String> semiImageString=[];
      List<String> superImageString=[];
      List<String> deluxImageString=[];

      hotelImageString.addAll(await uploadUrl(hotelImages, 'hotel/'));
      hotel.hotelimages = hotelImageString;
      //print(hotel.hotelimages);
      semiImageString.addAll(await uploadUrl(semiDeluImage, 'semi_room/'));
      superImageString.addAll(await uploadUrl(superDeluxImage, 'super_room/'));
      deluxImageString.addAll(await uploadUrl(DeluxImage, 'deluxe_room/'));

      hotel.deluxeimages=deluxImageString;
      hotel.semideluxeimages=semiImageString;
      hotel.superdeluxeimages=superImageString;
      hotel.hotelimages=hotelImageString;
      //print("json response:");
      //print(hotel.toJson());

      Response response =
          await dio.post('$baseUrl/hotel/addhotel', data: hotel.toJson());
      if (response.statusCode == 200) {

        Fluttertoast.showToast(
            msg: "Hotel Add Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: MakeMyTripColors.colorRed,
            textColor: MakeMyTripColors.colorWhite,
            fontSize: 16.0);
        return Right(null);
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
      var params = {"pagesize": 10, "page": page};
      final response = await dio.get('$baseUrl/hotel', queryParameters: params);
      debugPrint(params.toString());
      if (response.statusCode == 200) {
        final List<HotelModels> hotelList = [];
        final jsonList = response.data;
        for (var item in jsonList) {
          hotelList.add(HotelModels.fromJson(item));
        }
        return right(hotelList);
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
      final baseurl = '$baseUrl/hotel/deletehotel/${int.parse(id)}';
      final response = await dio.delete(baseurl);
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
      final response =
          await dio.get('$baseUrl/hotel/updatehoteldata/${int.parse(id)}');
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
  Future<Either<Failures, void>> updateHotel(hotelImages,
      superDeluxeImage,
      semiDeluxeImage,
      deluxeImage,
      HotelPutModel hotelPutModel) async {
    try {
      final response = await dio.put('$baseUrl/hotel/updatehotel',
          data: hotelPutModel.toJson());
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
        final ref =
            FirebaseStorage.instance.ref().child('$path/$imagePath');
        await ref.putData(webImage!);
        // ref.getDownloadURL().then((value) {
        //   print("getimage $value");
        //   // controller.insertNetworkImage(value);
        // });
        return const Right(null);
      } else {
        final webImage = null;
        final imagePath = '';
        return const Right(null);
      }
    }
    else {
      //print('Not web');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<PlatformFile>>> getHotelImage(String path) async {
    var data = '';
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'jpeg'],allowMultiple: true);
      if (result != null) {
        List<PlatformFile> files = result.files;
        // final imagePath = file.name;
        // final ref =
        //     FirebaseStorage.instance.ref().child('$path/$imagePath');
        // ref.getDownloadURL().then((val) {
        //   print("getimage $val");
        //   data = val;
        // });
        return Right(files);
      } else {
        final webImage = null;
        final imagePath = '';
        return const Right([]);
      }
    } else {
      print('Not web');
      return Left(ServerFailure());
    }
  }
}
