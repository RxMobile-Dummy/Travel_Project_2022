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
                'eyJhbGciOiJSUzI1NiIsImtpZCI6ImJmMWMyNzQzYTJhZmY3YmZmZDBmODRhODY0ZTljMjc4ZjMxYmM2NTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWthc2ggR3VwdGEiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FGZFp1Y3JZQnVDWUdVb1lXZnM0UGxNMDNWenZ4MDlHZzNWVTBlanhGenFjZ2c9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjU4NzU0MDI1LCJ1c2VyX2lkIjoiQ1JTdm15ZkdjTGY0ck1tWUJLUjdjZ2dnUDc0MiIsInN1YiI6IkNSU3ZteWZHY0xmNHJNbVlCS1I3Y2dnZ1A3NDIiLCJpYXQiOjE2NTg3NTQwMjUsImV4cCI6MTY1ODc1NzYyNSwiZW1haWwiOiJndXB0YWthc2g3MzgzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA3NzIzMjc3NTUyMDU2OTQ4MTY4Il0sImVtYWlsIjpbImd1cHRha2FzaDczODNAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.NBk4Jq9IrY-UhPmReq1gy0RlNDF-ejpJOYsRjviKLuNT-9fewGQZXv9py1SM4vecMwCqnKTdSFTz0-l1yXWOWxKedVXKIvhhxnCwatE1fkKJ-oyUsSaWC_kWmxGyCUjjDFR8IWYljgh4pa-JdQwSk7uQpYJ3T0yc59TNf1A1-fVi_Gaz6UDPqc5T2PU6Ep72YMa_wsv1-VS6hZdOj3QH9YwK_5hFN00TYbtBR3wVx1SAvWDODm9R_VRRy7jQsqokuRErO2ioU5ZieDHsfwCnQQ4C3wxmP4KVh79dLrDkmu2T14xP7lPMRAtXmuKQl5c_I7UgE5GiJKUJI3b_2Sbo3Q'
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

  @override
  Future<Either<Failures, void>> updateUserData(
      Map<String, String> postData) async {
    try {
      print(postData);
      final response = await dio.put(BaseConstant.baseUrl,
          data: postData,
          options: Options(headers: {
            "token":
                'eyJhbGciOiJSUzI1NiIsImtpZCI6ImJmMWMyNzQzYTJhZmY3YmZmZDBmODRhODY0ZTljMjc4ZjMxYmM2NTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWthc2ggR3VwdGEiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FGZFp1Y3JZQnVDWUdVb1lXZnM0UGxNMDNWenZ4MDlHZzNWVTBlanhGenFjZ2c9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vdHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXVkIjoidHJhdmVscHJvamVjdDIyLTZiOWQ0IiwiYXV0aF90aW1lIjoxNjU4NzU0MDI1LCJ1c2VyX2lkIjoiQ1JTdm15ZkdjTGY0ck1tWUJLUjdjZ2dnUDc0MiIsInN1YiI6IkNSU3ZteWZHY0xmNHJNbVlCS1I3Y2dnZ1A3NDIiLCJpYXQiOjE2NTg3NTQwMjUsImV4cCI6MTY1ODc1NzYyNSwiZW1haWwiOiJndXB0YWthc2g3MzgzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA3NzIzMjc3NTUyMDU2OTQ4MTY4Il0sImVtYWlsIjpbImd1cHRha2FzaDczODNAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZ29vZ2xlLmNvbSJ9fQ.NBk4Jq9IrY-UhPmReq1gy0RlNDF-ejpJOYsRjviKLuNT-9fewGQZXv9py1SM4vecMwCqnKTdSFTz0-l1yXWOWxKedVXKIvhhxnCwatE1fkKJ-oyUsSaWC_kWmxGyCUjjDFR8IWYljgh4pa-JdQwSk7uQpYJ3T0yc59TNf1A1-fVi_Gaz6UDPqc5T2PU6Ep72YMa_wsv1-VS6hZdOj3QH9YwK_5hFN00TYbtBR3wVx1SAvWDODm9R_VRRy7jQsqokuRErO2ioU5ZieDHsfwCnQQ4C3wxmP4KVh79dLrDkmu2T14xP7lPMRAtXmuKQl5c_I7UgE5GiJKUJI3b_2Sbo3Q'
          }));
      UserDetailsModel userModel;
      userModel = UserDetailsModel.fromJson({});
      if (response.statusCode == 200) {
        print("return right");
        return Right(null);
      } else {
        return Left(ServerFailure());
      }
    } catch (err) {
      return Left(ServerFailure());
    }
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

