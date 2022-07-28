import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/user_history/data/model/user_history_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

abstract class UserHistoryDataSource {
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData();
}

class UserHistoryDataSourceImpl implements UserHistoryDataSource {
  final Dio dio;

  UserHistoryDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    print(userToken);
    return Options(headers: {'token': userToken});
  }

  @override
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData() async {
    try {
      final response = await dio.get(
          '${BaseConstant.baseUrl}booking/user/bookings',
          options: await createDioOptions());
      if (response.statusCode == 200) {
        List<UserHistoryModel> userHistoryModel = [];
        final apidata = response.data;
        for (var item in apidata) {
          userHistoryModel.add(UserHistoryModel.fromJson(item));
        }
        return Right(userHistoryModel);
      }else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
  }
}
