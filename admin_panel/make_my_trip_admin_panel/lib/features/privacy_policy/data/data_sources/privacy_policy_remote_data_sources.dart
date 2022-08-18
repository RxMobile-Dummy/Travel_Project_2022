import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class PrivacyPolicyRemoteDataSources {
  Future<Either<Failures, List<ContentModel>>> getPrivacyPolicyData();
  Future<Either<Failures, String>> updatePrivacyPolicyData(String content);
}

class PrivacyPolicyRemoteDataSourcesImpl
    extends PrivacyPolicyRemoteDataSources {
  final FirebaseFirestore firebaseFirestore;
  PrivacyPolicyRemoteDataSourcesImpl(this.firebaseFirestore);

  @override
  Future<Either<Failures, List<ContentModel>>> getPrivacyPolicyData() async {
    try {
      List<ContentModel> contentModel = [];
      var snapshot = await firebaseFirestore.collection('privacyPolicy').get();
      snapshot.docs.map((doc) {
        contentModel.add(ContentModel.fromJson(doc.data()));
      }).toList();
      return Right(contentModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updatePrivacyPolicyData(
      String content) async {
    try {
      await firebaseFirestore
          .collection('privacyPolicy')
          .doc('hd2CM4A1Nm1iAQpqH8cj')
          .update({"title": content});
      return Right("");
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
