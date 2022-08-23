import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/usecases/usecase.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/approve_or_reject_review_usecase.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/get_all_reviews_usecase.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/domain/usecases/review_Image_delete.dart';
import 'package:make_my_trip_admin_panel/utils/constants/base_constants.dart';

class ReviewModerationCubit extends Cubit<BaseState> {
  ReviewModerationCubit(
      {required this.reviewImageDelete,
      required this.approveOrRejectReview,
      required this.getAllReviews})
      : super(StateInitial()) {
    getAllReviewsCubit();
  }

  final GetAllReviews getAllReviews;
  final ApproveOrRejectReview approveOrRejectReview;
  final ReviewImageDelete reviewImageDelete;

  List<ReviewModel> reviewList=[];

  getAllReviewsCubit() async {
    emit(StateLoading());
    reviewList.clear();
    try {
      final res = await getAllReviews.call(NoParams());
      res.fold((failure) {
        emit(BaseConstant.checkFailures(failure));
      }, (success) {
        reviewList.addAll(success);
        emit(StateOnSuccess<List<ReviewModel>>(reviewList));
      });
    } catch (err) {
      emit(StateErrorGeneral("Unexpected error"));
    }
  }

  approveOrRejectCubit(ReviewModel model, bool approved) async {
    emit(StateLoading());
    try {
      final res = await approveOrRejectReview
          .call(ApproveParams(reviewId: model.id!, approved: approved));
      res.fold((failure) {
        emit(BaseConstant.checkFailures(failure));
      }, (success) {
       getAllReviewsCubit();
      });
    } catch (err) {
      emit(StateErrorGeneral("Unexpected error"));
    }
  }

  reviewImageDeleteCubit(ReviewModel model,ReviewImage imageModel) async {
    emit(StateLoading());
    try {
      final res = await reviewImageDelete
          .call(ReviewImageDeleteParams(reviewId: model.id!, imageId: imageModel.imageId!));
      res.fold((failure) {
        emit(BaseConstant.checkFailures(failure));
      }, (success) {
        getAllReviewsCubit();
      });
    } catch (err) {
      emit(StateErrorGeneral("Unexpected error"));
    }
  }
}
