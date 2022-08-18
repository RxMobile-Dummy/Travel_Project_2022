import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class FaqRemoteDataSources {
  Future<Either<Failures, List<ContentModel>>> getFaqData();
  Future<Either<Failures, String>> updateFaqData(String title, String content);
}

class FaqRemoteDataSourcesImpl extends FaqRemoteDataSources {
  final FirebaseFirestore firebaseFirestore;
  FaqRemoteDataSourcesImpl(this.firebaseFirestore);

  @override
  Future<Either<Failures, List<ContentModel>>> getFaqData() async {
    try {
      List<ContentModel> contentModel = [];
      var snapshot = await firebaseFirestore.collection('faq').get();
      snapshot.docs.map((doc) {
        contentModel.add(ContentModel.fromJson(doc.data()));
      }).toList();
      return Right(contentModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, String>> updateFaqData(
      String title, String content) async {
    try {
      await firebaseFirestore
          .collection('faq')
          .doc('8dUrCfumVUNXTTqtIQBE')
          .update({"title": title, "subtitle": content});
      return Right("");
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
