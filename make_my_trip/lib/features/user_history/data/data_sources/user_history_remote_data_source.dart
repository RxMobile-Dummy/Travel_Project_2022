import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';
import '../model/user_history_model.dart';

abstract class UserHistoryDataSource {
  Future<Either<Failures, List<UserHistoryModel>>> getUserHistoryData();
}

class UserHistoryDataSourceImpl implements UserHistoryDataSource {
  final Dio dio;

  UserHistoryDataSourceImpl(this.dio);

  Future<Options> createDioOptions() async {
    final userToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    printWrapped(userToken);
    return Options(headers: {'token': userToken});
  }
  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
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
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print(err);
      return Left(ServerFailure());
    }
  }
}
