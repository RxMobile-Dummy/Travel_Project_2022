import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class UserDetailsRemoteDataSourceimpl implements UserDetailsRemoteDataSource {
  UserDetailsRemoteDataSourceimpl(this.dio);

  final Dio dio;
  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
  Future<Options> createDioOptions() async {
    final auth = FirebaseAuth.instance;
    final token = await auth.currentUser!.getIdToken();
   //  printWrapped(token);
    return Options(headers: {StringConstants.token:token});
  }

  @override
  Future<Either<Failures, UserDetailsModel>> getUserData() async {
    try {
      final response = await dio.get(
          BaseConstant.baseUrl + StringConstants.user,
          options: await createDioOptions());

      if (response.statusCode == 200) {
        UserDetailsModel userModel;
        final apidata = response.data[0];
        userModel = UserDetailsModel.fromJson(apidata);

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
          return Right(null);
        } else {
          return Left(ServerFailure());
        }
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updateImagefromGallery() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
      if (pickedFile == null) {
        return Right(StringConstants.emptyString);
      }
      if (pickedFile != null) {
        final path = StringConstants.firebaseFolderName + pickedFile.name;
        final filename = File(pickedFile.path);
        final ref = FirebaseStorage.instance.ref().child(path);

        await ref.putFile(filename);

        var mapdata = {StringConstants.imageJson: await ref.getDownloadURL()};

        await FirebaseFirestore.instance
            .collection(StringConstants.firebaseCollectionName)
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set(mapdata)
            .onError((error, stackTrace) => null);
        print(await  createDioOptions());
        await dio.put(BaseConstant.baseUrl + StringConstants.user,
            data: mapdata,
            options: await createDioOptions());

        return Right(mapdata.entries.first.value.toString());
      } else {
        return Left(ErrorWithMessageFailure(StringConstants.failedToLoadImg));
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updateImagefromCamera() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile == null) {
        return Right(StringConstants.emptyString);
      }
      if (pickedFile != null) {
        final path = StringConstants.firebaseFolderName + pickedFile.name;
        final filename = File(pickedFile.path);
        final ref = FirebaseStorage.instance.ref().child(path);

        await ref.putFile(filename);

        var mapdata = {StringConstants.imageJson: await ref.getDownloadURL()};

        await FirebaseFirestore.instance
            .collection(StringConstants.firebaseCollectionName)
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set(mapdata)
            .onError((error, stackTrace) => print(error));

        await dio.put(BaseConstant.baseUrl + StringConstants.user,
            data: mapdata,
            options: await createDioOptions());
        return Right(mapdata.entries.first.value.toString());
      } else {
        return Left(ErrorWithMessageFailure(StringConstants.failedToLoadImg));
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
