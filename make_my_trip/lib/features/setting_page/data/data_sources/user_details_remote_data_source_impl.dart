import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/utils/constants/base_constants.dart';

class UserDetailsRemoteDataSourceimpl implements UserDetailsRemoteDataSource {
  UserDetailsRemoteDataSourceimpl(this.dio);
  final Dio dio;
  @override
  Future<Either<Failures, UserDetailsModel>> getUserData() async {
    try {
      final response = await dio.get(BaseConstant.baseUrl,
          options: Options(headers: {
            "token":
                'eyJhbGciOiJSUzI1NiIsImtpZCI6ImJmMWMyNzQzYTJhZmY3YmZmZDBmODRhODY0ZTljMjc4ZjMxYmM2NTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWthc2ggR3VwdGEiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FGZFp1Y3JZQnVDWUdVb1lXZnM0UGxNMDNWenZ4MDlHZzNWVTBlanhGenFjZ2c9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjU4NTg1OTcxLCJ1c2VyX2lkIjoiQ1JTdm15ZkdjTGY0ck1tWUJLUjdjZ2dnUDc0MiIsInN1YiI6IkNSU3ZteWZHY0xmNHJNbVlCS1I3Y2dnZ1A3NDIiLCJpYXQiOjE2NTg1ODU5NzEsImV4cCI6MTY1ODU4OTU3MSwiZW1haWwiOiJndXB0YWthc2g3MzgzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA3NzIzMjc3NTUyMDU2OTQ4MTY4Il0sImVtYWlsIjpbImd1cHRha2FzaDczODNAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.EuB16n6pOtSY-DL48jW4I93F6BcgfAUSyj4oJloeCzMbyOJsog1SgRu_7_SF_pXHLZmuZJ-9efSOm5PVC5mCDqmkPv96cq1A-My8MMzDhu7yx0lzz07rCr2wNYwDbfiQuv2gDOLq54NeRnY4hiKbrw_tZGJNRjIi4hvIb5-GRAepQ4VtmUGuW1im-l1ztSU8S5LgpsK9bQ_QYd9VVtQYN6gkjRZNhQQlEBxSaGC4PqvMKdn8c3xMCgYL3gK4BYdqmyHuGrPbanmxoS8EEYdBBDQEpfrN9PJR4Lch9wzVKQH2q63UotYZY1x8jAfmz1950-6U5kYw2o4iTLNYq-59PA'
          }));

      if (response.statusCode == 200) {
        UserDetailsModel userModel;
        print(response.data);
        final apidata = response.data[0];
        userModel = UserDetailsModel.fromJson(apidata);
        print("return right");
        return Right(userModel);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      print("err");
      return Left(ServerFailure());
    }
  }
  // Future<Either<Failures, UserModel>> getUserData(String params) async {
  //   try {
  //     final response = await dio.get(BaseConstant.baseUrl + params);

  //     if (response.statusCode == 200) {
  //       UserModel userModel;
  //       final apidata = response.data;
  //       userModel = UserModel.fromJson(apidata);
  //       return Right(userModel);
  //     } else {
  //       return Left(ServerFailure());
  //     }
  //   } catch (err) {
  //     return Left(ServerFailure());
  //   }
  // }
}
