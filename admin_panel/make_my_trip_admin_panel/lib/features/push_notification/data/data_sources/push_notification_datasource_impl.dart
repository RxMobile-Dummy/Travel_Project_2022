import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/data/data_sources/push_notification_datasource.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class PushNotificationDataSourceImpl implements PushNotificationDataSource {
  Dio dio;
  PushNotificationDataSourceImpl(this.dio);

  @override
  Future<Either<Failures, List<dynamic>>> getImageFromDevice() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 30,
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      final path = "pushNotification/${pickedFile!.name}";
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref
          .putData(
            await pickedFile.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
          .whenComplete(() => Fluttertoast.showToast(
              msg: StringConstants.imageUploadedSuccessfully))
          .catchError((err) => Fluttertoast.showToast(
              msg:
                  "Something went wrong while uploading image , please try again latter !"));
      var url = await ref.getDownloadURL();
      return Right([pickedFile.name, url]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> registeredUserUseCase(
      title, body, url) async {
    try {
      var response = await dio
          .post("https://274c-180-211-112-179.in.ngrok.io/broadcast/registered",
              data: {
                "title": title,
                "body": body,
                "imageUrl": url.toString().trim(),
                "topic": "Events"
              },
              options: await BaseConstant.createDioOptions())
          .catchError(
              (err) => Fluttertoast.showToast(msg: StringConstants.notSend));
      return Right(response.data.toString());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> endUserUseCase(title, body, url) async {
    try {
      var response = await Dio()
          .post("https://906d-180-211-112-179.in.ngrok.io/broadcast/endUser",
              data: {
                "title": title,
                "body": body,
                "imageUrl": url.toString().trim()
              },
              options: await BaseConstant.createDioOptions())
          .catchError(
              (err) => Fluttertoast.showToast(msg: StringConstants.notSend));
      return Right(response.data.toString());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
