import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/presentation/cubit/publish_review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/widgets/publish_review_slider_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class PublishReviewPage extends StatelessWidget {
  PublishReviewPage({Key? key, required this.arg}) : super(key: key);
  final TextEditingController reviewController = TextEditingController();
  Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, BaseState>(
      listener: (context, state) {
        if (state is StateOnKnownToSuccess) {
          Navigator.of(context).pushReplacementNamed(RoutesName.reviewPage,
              arguments: {
                "hotel_id": arg["hotel_id"],
                'rating': arg['rating']
              });
        } else if (state is ValidationError) {
          // var snackBar = SnackBar(content: Text(state.errorMessage));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is StateNoData) {
          var snackBar =
              SnackBar(content: Text(StringConstants.noReviewComment));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
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
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                    child: Text(StringConstants.publish,
                        style: AppTextStyles.infoContentStyle2),
                    onPressed: () {
                      if (state.commentReview.isEmpty ||
                          state.commentReview == null ||
                          state.commentReview.length == 0 ||
                          state.commentReview.toString().trim().length == 0) {
                        var snackBar = SnackBar(
                            content: Text(StringConstants.pleaseEntCom));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      context.read<ReviewCubit>().postHotelReviewData(
                          state.commentReview,
                          state.cleanlinessReview,
                          state.locationReview,
                          state.comfortReview,
                          state.facilitiesReview,
                          arg['hotel_id']);
                    },
                  ),
                );
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
                    fieldName: StringConstants.cleanlinessTxt,
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
                    fieldName: StringConstants.comfortTxt,
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
                    fieldName: StringConstants.loacationTxt,
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
                    fieldName: StringConstants.facilitiesTxt,
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
      ),
    );
  }
}
