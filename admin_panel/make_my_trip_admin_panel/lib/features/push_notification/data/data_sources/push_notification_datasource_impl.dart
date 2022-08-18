import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip_admin_panel/core/failures/failures.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/data/data_sources/push_notification_datasource.dart';

class PushNotificationDaaSource_Impl implements PushNotificationDataSource{
  @override
  Future<Either<Failures, List<dynamic>>> getImageFromDevice() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        imageQuality: 20,
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      final path = "pushNotification/${pickedFile!.name}";
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putData(await pickedFile.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),).whenComplete(() =>
          Fluttertoast.showToast(msg: "Image Uploaded Successfully"));
      var url = await ref.getDownloadURL();
      return Right([pickedFile.name, url]);
    }catch(e){
      return Left(ServerFailure());
    }
  }

}