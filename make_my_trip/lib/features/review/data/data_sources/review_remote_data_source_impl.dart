import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;

  ReviewRemoteDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, ReviewModel>> getHotelReview(params) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}review/hotel/${params}',
          options: await createDioOptions());
      if (response.statusCode == 200) {
        ReviewModel reviewModel = ReviewModel.fromJson(response.data);
        return Right(reviewModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  Future<List<String>> uploadUrl(List<XFile> imageFileList) async {
    List<String> imageUrl = [];
    for(var e in imageFileList){
      final path =
          StringConstants.firebaseReviewFolderName + "image" + e.name;
      final filename = File(e.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      try {
        await uploadimageGallery(filename, e, ref);
      } catch (e) {}
      imageUrl.add(await ref.getDownloadURL());
    }

    return imageUrl;
  }

  @override
  Future<Either<Failures, void>> postHotelReview(
      Reviews reviewModel, int hotel_id, List<XFile> imageFileList) async {
    try {
      List<String> imageUrl = [];
      if (imageFileList.isNotEmpty) {
        imageUrl.addAll(await uploadUrl(imageFileList));
        reviewModel.images = imageUrl;
        final response = await dio.post(
            '${BaseConstant.baseUrl}review/hotel/${int.parse(hotel_id.toString())}',
            data: reviewModel.toJson(),
            options: await createDioOptions());
        if (response.statusCode == 200) {
          return Right(null);
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failures, String>> updloadImagesFromGallery() async {
  //   //changes for uploading img 23Aug
  //   try {
  //     List<XFile>? pickedFile = await ImagePicker().pickMultiImage(
  //       maxWidth: 60,
  //       maxHeight: 60,
  //       imageQuality: 40,
  //     );
  //     if (pickedFile == null) {
  //       return const Right(StringConstants.emptyString);
  //     } else {
  //       return Left(ServerFailure());
  //     }
  //     // if (pickedFile != null) {
  //     //   pickedFile.forEach((element) async{
  //     //     final path = StringConstants.firebaseFolderName + pickedFile[0].name;
  //     //     final filename = File(element.path);
  //     //     final ref = FirebaseStorage.instance.ref().child(path);
  //     //     try {
  //     //       FlutterIsolate.spawn(
  //     //           await uploadimageGallery(filename, element, ref),
  //     //           StringConstants.galleryIsolate);
  //     //     } catch (e) {}
  //     //     var mapData = {StringConstants.imageJson: await ref.getDownloadURL()};
  //     //     await FirebaseFirestore.instance
  //     //         .collection(StringConstants.firebaseCollectionName)
  //     //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //     //         .set(mapData)
  //     //         .onError((error, stackTrace) => null);
  //     //     await dio.put(BaseConstant.baseUrl + StringConstants.user,
  //     //         data: mapData, options: await createDioOptions());
  //     //   });
  //     //   // return Right(mapData.entries.first.value.toString());
  //     //   print("Hopefully selected");
  //     //   return Right("done");
  //     // } else {
  //     //   return Left(ErrorWithMessageFailure(StringConstants.failedToLoadImg));
  //     // }
  //   } catch (err) {
  //     return Left(ServerFailure());
  //   }
  // }

  uploadimageGallery(File filename, XFile pickedFile, Reference ref) async {
    //changes for uploading img 23Aug
    await ref.putFile(filename);
  }

  uploadimageCamera(File filename, XFile pickedFile, Reference ref) async {
    //changes for uploading img 23Aug
    await ref.putFile(filename);
  }
}
