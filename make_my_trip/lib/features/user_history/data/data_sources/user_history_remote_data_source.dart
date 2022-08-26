import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import '../model/user_history_model.dart';

abstract class UserHistoryDataSource {
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData(int page);
}

class UserHistoryDataSourceImpl implements UserHistoryDataSource {
  final Dio dio;

  UserHistoryDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    return Options(headers: {'token': userToken});
  }
  @override
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData(
      page) async {
    try {
      final params = <String, dynamic>{
        'pagesize': 6,
        'page': page,
      };
      final response = await dio.get(
          '${BaseConstant.baseUrl}booking/user/bookings',
          queryParameters: params,
          options: await createDioOptions());
      if (response.statusCode == 200) {
        List<UserHistoryModel> userHistoryModel = [];
        final apidata = response.data;
        for (var item in apidata) {
          userHistoryModel.add(UserHistoryModel.fromJson(item));
        }
        return Right(userHistoryModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
