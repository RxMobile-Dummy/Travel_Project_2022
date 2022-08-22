import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/usecases/approve_or_reject_review_usecase.dart';
import '../../domain/usecases/review_Image_delete.dart';
import '../models/review_model.dart';

abstract class ReviewModerationRemoteDataSource {
  Future<Either<Failures, List<ReviewModel>>> getAllReviews();
  Future<Either<Failures, List<ReviewModel>>> approveOrRejectReview(
      ApproveParams params);
  Future<Either<Failures, List<ReviewModel>>> reviewImageDelete(
      ReviewImageDeleteParams params);
}

class ReviewModerationRemoteDataSourceImpl
    implements ReviewModerationRemoteDataSource {
  final Dio dio;

  ReviewModerationRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failures, List<ReviewModel>>> getAllReviews() async {
    try {
      final res = await dio.get("${BaseConstant.baseUrl}review/reviewpending/",
          options: await BaseConstant.createDioOptions());

      final apiData = res.data;
      List<ReviewModel> reviewList = [];

      for (var element in apiData) {
        reviewList.add(ReviewModel.fromJson(element));
      }
      print(reviewList);
      return Right(reviewList);
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<ReviewModel>>> approveOrRejectReview(
      ApproveParams params) async {
    try {
      final res = await dio.get("${BaseConstant.baseUrl}review/reviewapprove/",
          queryParameters: {
            "approve": params.approved,
            "review_id": params.reviewId
          },
          options: await BaseConstant.createDioOptions());

      final apiData = res.data;
      List<ReviewModel> reviewList = [];
      for (var element in apiData) {
        reviewList.add(ReviewModel.fromJson(element));
      }
      return Right(reviewList);
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      print(err);
      debugPrint(err.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, List<ReviewModel>>> reviewImageDelete(
      ReviewImageDeleteParams params) async {
    try {
      final res = await dio.get(
          "${BaseConstant.baseUrl}review/reviewimageapprove/",
          queryParameters: {
            "image_id": params.imageId,
            "review_id": params.reviewId
          },
          options: await BaseConstant.createDioOptions());

      final apiData = res.data;
      List<ReviewModel> reviewList = [];
      for (var element in apiData) {
        reviewList.add(ReviewModel.fromJson(element));
      }
      return Right(reviewList);
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }
}
