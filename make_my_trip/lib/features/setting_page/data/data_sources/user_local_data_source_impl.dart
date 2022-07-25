import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_details_remote_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/data_sources/user_local_data_source.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';

class UserDetailsLocalDataSourceimpl implements UserDetailsLocalDataSource {
  UserDetailsLocalDataSourceimpl();

  @override
  Future<Either<Failures, String>> updateImagefromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      final path = 'userImage/${pickedFile.name}';
      final filename = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child(path)
          .putFile(filename)
          .then((p0) => print(p0));

      // final usercollectionref = FirebaseFirestore.instance.collection("Images");
      // var mapdata = {"url": await ref.getDownloadURL()};

      // usercollectionref
      //     .doc(FirebaseAuth.instance.currentUser?.uid)
      //     .set(mapdata)
      //     .then((value) {
      //   print("success");
      // });
      // ref.putFile(filename).then((p0) {
      //   downloadurltofirestore();

      // }

      return Right(pickedFile.path);
    } else {
      return Left(ErrorWithMessageFailure('faild to add image'));
    }
  }

  @override
  Future<Either<Failures, String>> updateImagefromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      return Right(pickedFile.path);
    } else {
      return Left(ErrorWithMessageFailure('faild to add image'));
    }
  }
}
