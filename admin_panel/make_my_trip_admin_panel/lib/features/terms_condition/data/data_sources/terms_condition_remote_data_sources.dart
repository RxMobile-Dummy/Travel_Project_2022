import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../../../utils/html_editor/content_model.dart';

abstract class TermsConditionRemoteDataSources {
  Future<Either<Failures, List<ContentModel>>> getTermsConditionData();
  Future<Either<Failures, void>> updateTermsConditionData(String content);
}

class TermsConditionRemoteDataSourcesImpl
    extends TermsConditionRemoteDataSources {
  final FirebaseFirestore firebaseFirestore;
  TermsConditionRemoteDataSourcesImpl(this.firebaseFirestore);

  @override
  Future<Either<Failures, List<ContentModel>>> getTermsConditionData() async {
    try {
      List<ContentModel> contentModel = [];
      var snapshot =
          await firebaseFirestore.collection('termsAndCondition').get();
      snapshot.docs.map((doc) {
        contentModel.add(ContentModel.fromJson(doc.data()));
      }).toList();
      return Right(contentModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failures, void>> updateTermsConditionData(
      String content) async {
    try {
      await firebaseFirestore
          .collection('termsAndCondition')
          .doc('lUv86e95qvAgXKsNPFuK')
          .update({"title": content});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
