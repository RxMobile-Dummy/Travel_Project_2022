import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/presentation/cubit/publish_review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/widgets/publish_review_slider_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class PublishReviewPage extends StatelessWidget {
  PublishReviewPage({Key? key}) : super(key: key);
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            StringConstants.writeAReview,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close,
                color: MakeMyTripColors.accentColor, size: 25)),
        actions: [
          BlocBuilder<PublishReviewCubit, ReviewValueState>(
            builder: (context, state) {
              return GestureDetector(
                  onTap: () {
                    ReviewModel reviewModel = ReviewModel(
                      comment: state.commentReview,
                      cleanliness: state.cleanlinessReview,
                      comfort: state.comfortReview,
                      location: state.locationReview,
                      facilities: state.facilitiesReview,
                    );
                    context
                        .read<ReviewCubit>()
                        .postHotelReviewData(reviewModel);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Center(
                      child: Text(
                        StringConstants.publish,
                        style: AppTextStyles.infoContentStyle2,
                      ),
                    ),
                  ));
            },
          )
        ],
      ),
      body: BlocBuilder<PublishReviewCubit, ReviewValueState>(
        builder: (context, state) {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  children: [
                    const Icon(
                      Icons.add_circle,
                      color: MakeMyTripColors.color50gray,
                    ),
                    10.horizontalSpace,
                    Text(StringConstants.review,
                        style: AppTextStyles.unselectedLabelStyle)
                  ],
                ),
                16.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 38, right: 8),
                  child: TextFormField(
                    maxLength: 200,
                    maxLines: 5,
                    controller: reviewController,
                    onChanged: (val) {
                      val = reviewController.text;
                      context
                          .read<PublishReviewCubit>()
                          .onChangeCommentReviewValueEvent(val);
                    },
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MakeMyTripColors.color90gray)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MakeMyTripColors.color70gray)),
                        hintStyle: AppTextStyles.infoContentStyle),
                  ),
                ),
                24.verticalSpace,
                PublishReviewSliderWidget(
                  fieldName: 'Cleanliness',
                  value: state.cleanlinessReview,
                  context: context,
                  callback: (double val) {
                    context
                        .read<PublishReviewCubit>()
                        .onChangeCleanlinessReviewValueEvent(val);
                  },
                ),
                16.verticalSpace,
                PublishReviewSliderWidget(
                  fieldName: 'Comfort',
                  value: state.comfortReview,
                  context: context,
                  callback: (double val) {
                    context
                        .read<PublishReviewCubit>()
                        .onChangeComfortReviewValueEvent(val);
                  },
                ),
                16.verticalSpace,
                PublishReviewSliderWidget(
                  fieldName: 'Location',
                  value: state.locationReview,
                  context: context,
                  callback: (double val) {
                    context
                        .read<PublishReviewCubit>()
                        .onChangeLocationReviewValueEvent(val);
                  },
                ),
                16.verticalSpace,
                PublishReviewSliderWidget(
                  fieldName: 'Facilities',
                  value: state.facilitiesReview,
                  context: context,
                  callback: (double val) {
                    context
                        .read<PublishReviewCubit>()
                        .onChangeFacilitiesReviewValueEvent(val);
                  },
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
