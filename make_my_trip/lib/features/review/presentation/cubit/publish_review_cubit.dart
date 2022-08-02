import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/review/domain/use_cases/post_hotel_review_usecase.dart';

class PublishReviewCubit extends Cubit<ReviewValueState> {
  final PostHotelReviewUseCases postHotelReviewUseCases;

  PublishReviewCubit(this.postHotelReviewUseCases)
      : super( ReviewValueState(
            cleanlinessReview: 0.0,
            comfortReview: 0.0,
            locationReview: 0.0,
            facilitiesReview: 0.0,
            commentReview: ""));

  onChangeCleanlinessReviewValueEvent(double? cleanlinessRating) {
    emit(state.copyWith(cleanlinessReview: cleanlinessRating));
  }

  onChangeComfortReviewValueEvent(double comfortRating) {
    emit(state.copyWith(comfortReview: comfortRating));
  }

  onChangeLocationReviewValueEvent(double locationRating) {
    emit(state.copyWith(locationReview: locationRating));
  }

  onChangeFacilitiesReviewValueEvent(double facilitiesRating) {
    emit(state.copyWith(facilitiesReview: facilitiesRating));
  }

  onChangeCommentReviewValueEvent(String comment) {
    emit(state.copyWith(commentReview: comment));
  }
}

class ReviewValueState extends Equatable {
  final double cleanlinessReview;
  final double comfortReview;
  final double locationReview;
  final double facilitiesReview;
  final String commentReview;

  const ReviewValueState({
    required this.cleanlinessReview,
    required this.comfortReview,
    required this.locationReview,
    required this.facilitiesReview,
    required this.commentReview,
  });

  ReviewValueState copyWith(
          {double? cleanlinessReview,
          double? comfortReview,
          double? locationReview,
          double? facilitiesReview,
          String? commentReview}) =>
      ReviewValueState(
          cleanlinessReview: cleanlinessReview ?? this.cleanlinessReview,
          comfortReview: comfortReview ?? this.comfortReview,
          locationReview: locationReview ?? this.locationReview,
          facilitiesReview: facilitiesReview ?? this.facilitiesReview,
          commentReview: commentReview ?? this.commentReview);

  @override
  List<Object?> get props => [
        cleanlinessReview,
        comfortReview,
        locationReview,
        facilitiesReview,
        commentReview
      ];
}
