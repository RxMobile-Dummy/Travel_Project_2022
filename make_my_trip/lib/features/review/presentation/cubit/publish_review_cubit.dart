import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/features/review/domain/use_cases/post_hotel_review_usecase.dart';

class PublishReviewCubit extends Cubit<ReviewValueState> {
  final PostHotelReviewUseCases postHotelReviewUseCases;

  PublishReviewCubit(this.postHotelReviewUseCases)
      : super(ReviewValueState(
          cleanlinessReview: 0.0,
          comfortReview: 0.0,
          locationReview: 0.0,
          facilitiesReview: 0.0,
          commentReview: "",
          imageFileList: [],
        ));

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

   selectImages() async {
    List<XFile>? imageFileList=[];
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      emit(state.copyWith(imageFileList: imageFileList));
    }
  }
}

class ReviewValueState extends Equatable {
  final double cleanlinessReview;
  final double comfortReview;
  final double locationReview;
  final double facilitiesReview;
  final String commentReview;
  final List<XFile>? imageFileList;

  const ReviewValueState(
      {required this.cleanlinessReview,
      required this.comfortReview,
      required this.locationReview,
      required this.facilitiesReview,
      required this.commentReview,
      required this.imageFileList});

  ReviewValueState copyWith(
          {double? cleanlinessReview,
          double? comfortReview,
          double? locationReview,
          double? facilitiesReview,
          String? commentReview,
          List<XFile>? imageFileList}) =>
      ReviewValueState(
          cleanlinessReview: cleanlinessReview ?? this.cleanlinessReview,
          comfortReview: comfortReview ?? this.comfortReview,
          locationReview: locationReview ?? this.locationReview,
          facilitiesReview: facilitiesReview ?? this.facilitiesReview,
          commentReview: commentReview ?? this.commentReview,
          imageFileList: imageFileList ?? this.imageFileList);

  @override
  List<Object?> get props => [
        cleanlinessReview,
        comfortReview,
        locationReview,
        facilitiesReview,
        commentReview,
        imageFileList
      ];
}
