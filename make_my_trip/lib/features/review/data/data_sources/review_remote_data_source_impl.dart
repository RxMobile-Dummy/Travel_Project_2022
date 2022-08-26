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
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;

  ReviewRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, GetReviewModel>> getHotelReview(params) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}review/hotel/${params}',
          options: await BaseConstant.createDioOptions());
      if (response.statusCode == 200) {
        GetReviewModel reviewModel = GetReviewModel.fromJson(response.data);
        return Right(reviewModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }

  Future<List<String>> uploadUrl(List<String> imageFileList) async {
    List<String> imageUrl = [];
    for(var e in imageFileList){
      final path =
          StringConstants.firebaseReviewFolderName + "image" + e;
      final filename = File(e);
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
      Reviews reviewModel, int hotel_id, List<String> imageFileList) async {
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



  uploadimageGallery(File filename, String pickedFile, Reference ref) async {
    await ref.putFile(filename);
  }

  uploadimageCamera(File filename, String pickedFile, Reference ref) async {
    await ref.putFile(filename);
  }
}
