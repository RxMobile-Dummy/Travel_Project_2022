import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/pages/review_shimmer_page.dart';
import 'package:make_my_trip/features/review/presentation/widgets/review_card_widget.dart';
import 'package:make_my_trip/features/review/presentation/widgets/review_slider_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../utils/widgets/common_error_widget.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({Key? key, required this.arg}) : super(key: key);
  Map<String, dynamic> arg;
  @override
  Widget build(BuildContext context) {
    GetReviewModel? review;
    List<Review>? reviewModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.reviews,
          style: AppTextStyles.unselectedLabelStyle,
        ),
      ),
      body: BlocBuilder<ReviewCubit, BaseState>(
        builder: (context, state) {
          if (state is StateErrorGeneralStateErrorServer) {
            return CommonErrorWidget(
              onTap: () {
                BlocProvider.of<ReviewCubit>(context)
                    .getHotelReviewData(arg['hotel_id']);
              },
            );
          } else if (state is StateInternetError) {
            return CommonErrorWidget(
              title: StringConstants.internetErrorTitle,
              subTitle: StringConstants.internetErrorSubTitle,
              onTap: () {
                BlocProvider.of<ReviewCubit>(context)
                    .getHotelReviewData(arg['hotel_id']);
              },
            );
          } else if (state is StateOnSuccess) {
            review = state.response;
            reviewModel = review?.review;
            if (reviewModel!.length == 0) {
              return const CommonErrorWidget(
                  imagePath: ImagePath.noBookingPage,
                  subTitle: "We don't have any reviews for this hotel!",
                  title: "No review found");
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: MakeMyTripColors.accentColor,
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      review!.hotelRating!.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: MakeMyTripColors.color70gray),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Based on our ${reviewModel!.length} users",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: MakeMyTripColors.color70gray),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )),
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: VerticalDivider(
                                thickness: 1,
                                color: MakeMyTripColors.color30gray,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ReviewSliderWidget(
                                    value: review!.avgComfort!,
                                    fieldName: StringConstants.comfortTxt,
                                    context: context,
                                  ),
                                  ReviewSliderWidget(
                                    value: review!.avgCleanliness!,
                                    fieldName: StringConstants.cleanlinessTxt,
                                    context: context,
                                  ),
                                  ReviewSliderWidget(
                                    value: review!.avgLocation!,
                                    fieldName: StringConstants.loacationTxt,
                                    context: context,
                                  ),
                                  ReviewSliderWidget(
                                    value: review!.avgFacilities!,
                                    fieldName: StringConstants.facilitiesTxt,
                                    context: context,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviewModel!.length,
                        itemBuilder: (context, index) {
                          return ReviewCardWidget(
                            date: reviewModel![index].date?.substring(0, 10) ??
                                "",
                            name:
                                reviewModel![index].userId?.userName ?? "Name",
                            description:
                                reviewModel![index].comment ?? "Comments",
                            ratingValue: reviewModel![index].rating ?? 0.0,
                            image: reviewModel![index].userId?.userImage ??
                                StringConstants.userImagePlaceHolder,
                            uploadedImages: reviewModel![index].image!,
                            uploadedImgCount: reviewModel![index].image!.length,
                          );
                        }),
                  ],
                ),
              );
            }
          } else {
            return const ReviewPageShimmer();
          }
        },
      ),
    );
  }
}
