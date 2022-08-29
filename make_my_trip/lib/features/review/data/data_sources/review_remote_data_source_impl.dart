import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/review/data/data_sources/review_remote_data_source.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

import '../../../../core/failures/failure_handler.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final Dio dio;

  ReviewRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, GetReviewModel>> getHotelReview(params) async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}review/hotel/${params}',
          options: await BaseConstant.createDioOptions());
      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        GetReviewModel reviewModel = GetReviewModel.fromJson(response.data);
        return Right(reviewModel);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }

  Future<List<String>> uploadUrl(List<String> imageFileList) async {
    List<String> imageUrl = [];
    for (var e in imageFileList) {
      final path = StringConstants.firebaseReviewFolderName + "image" + e;
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
            options: await BaseConstant.createDioOptions());
        if (response.statusCode == 200) {
          return Right(null);
        } else {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
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
