import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class AboutUsRemoteDataSources {
  Future<Either<Failures, List<ContentModel>>> getAboutUsData();
  Future<Either<Failures, String>> updateAboutUsData(String content);
}

class AboutUsRemoteDataSourcesImpl implements AboutUsRemoteDataSources {
  final FirebaseFirestore firebaseFirestore;
  AboutUsRemoteDataSourcesImpl(this.firebaseFirestore);

  @override
  Future<Either<Failures, List<ContentModel>>> getAboutUsData() async {
    try {
      List<ContentModel> contentModel = [];
      var snapshot = await firebaseFirestore.collection('aboutUs').get();
      snapshot.docs.map((doc) {
        contentModel.add(ContentModel.fromJson(doc.data()));
      }).toList();
      return Right(contentModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updateAboutUsData(String content) async {
    try {
      await firebaseFirestore
          .collection('aboutUs')
          .doc('nCI6hhqwKi2nweCpZYxL')
          .update({"title": content});
      return Right("");
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
