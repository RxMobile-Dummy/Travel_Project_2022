import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:make_my_trip/features/home_page/data/data_sources/images_datasource.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import '../../../../core/failures/failure_handler.dart';
import '../../../../core/failures/failures.dart';
import '../../../hotel_listing/data/models/hotel_list_model.dart';

class ImagesDataSourceImpl implements ImagesDataSource {
  final Dio dio;

  ImagesDataSourceImpl(this.dio);
  @override
  Future<Either<Failures, List<HotelListModel>>> getList(int val) async {
    try {
      final response = await dio.get('${BaseConstant.baseUrl}hotel/image/$val',
          options: await BaseConstant.createDioOptions());

      final res = await FailureHandler.handleError(response);
      return res.fold((l) => Left(l), (r) {
        final postList = r.data
            .map<HotelListModel>((i) => HotelListModel.fromJson(i))
            .toList();

        return Right(postList);
      });
    } on SocketException {
      return Left(InternetFailure());
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
