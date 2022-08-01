import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class UserDetailsRemoteDataSourceImpl implements UserDetailsRemoteDataSource {
  UserDetailsRemoteDataSourceImpl(this.dio);

  final Dio dio;

  Future<Options> createDioOptions() async {
    final auth = FirebaseAuth.instance;
    final token = await auth.currentUser!.getIdToken();
    return Options(headers: {StringConstants.token: token});
  }

  @override
  Future<Either<Failures, UserDetailsModel>> getUserData() async {
    try {
      final response = await dio.get(
          BaseConstant.baseUrl + StringConstants.user,
          options: await createDioOptions());

      if (response.statusCode == 200) {
        UserDetailsModel userModel;
        final apiData = response.data[0];
        userModel = UserDetailsModel.fromJson(apiData);
        return Right(userModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> updateUserData(
      Map<String, String> postData) async {
    String userName = postData.entries.first.value.trim().toString();
    String userNumber = postData.entries.last.value.trim().toString();
    try {
      if (userName == null || userName == StringConstants.emptyString) {
        return Left(ErrorWithMessageFailure(StringConstants.validUserName));
      } else if (userNumber == null ||
          userNumber == StringConstants.emptyString ||
          userNumber.length > 13 ||
          userNumber.length < 10) {
        return Left(ErrorWithMessageFailure(StringConstants.validPhoneNumber));
      } else {
        final response = await dio.put(
            BaseConstant.baseUrl + StringConstants.user,
            data: postData,
            options: await createDioOptions());
        if (response.statusCode == 200) {
          return const Right(null);
        } else {
          return Left(ServerFailure());
        }
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updateImageFromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 20,
          source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
      if (pickedFile == null) {
        return const Right(StringConstants.emptyString);
      }
      if (pickedFile != null) {
        final path = StringConstants.firebaseFolderName + pickedFile.name;
        final filename = File(pickedFile.path);
        final ref = FirebaseStorage.instance.ref().child(path);

        try {
          FlutterIsolate.spawn(
             await uploadimageGallery(filename, pickedFile, ref), StringConstants.galleryIsolate);
        }
        catch(e){

        }
        var mapData = {StringConstants.imageJson: await ref.getDownloadURL()};
        await FirebaseFirestore.instance
            .collection(StringConstants.firebaseCollectionName)
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set(mapData)
            .onError((error, stackTrace) => null);
        await dio.put(BaseConstant.baseUrl + StringConstants.user,
            data: mapData, options: await createDioOptions());

        return Right(mapData.entries.first.value.toString());
      } else {
        return Left(ErrorWithMessageFailure(StringConstants.failedToLoadImg));
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updateImageFromCamera() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 20,
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile == null) {
        return const Right(StringConstants.emptyString);
      }
      if (pickedFile != null) {
        final path = StringConstants.firebaseFolderName + pickedFile.name;
        final filename = File(pickedFile.path);
        final ref = FirebaseStorage.instance.ref().child(path);
        try {
          FlutterIsolate.spawn(
              await uploadimageCamera(filename, pickedFile, ref), StringConstants.cameraIsolate);
        }
        catch(e){

        }

        var mapData = {StringConstants.imageJson: await ref.getDownloadURL()};


        await FirebaseFirestore.instance
            .collection(StringConstants.firebaseCollectionName)
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set(mapData)
            .onError((error, stackTrace) => print(error));

        await dio.put(BaseConstant.baseUrl + StringConstants.user,
            data: mapData, options: await createDioOptions());
        await Fluttertoast.showToast(msg: StringConstants.imageUploadSucefullytxt);
        return Right(mapData.entries.first.value.toString());
      } else {
        return Left(ErrorWithMessageFailure(StringConstants.failedToLoadImg));
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  uploadimageGallery(File filename, XFile pickedFile, Reference ref) async{
    await ref.putFile(filename);

  }
  uploadimageCamera(File filename, XFile pickedFile, Reference ref) async{
    await ref.putFile(filename);

  }
}
