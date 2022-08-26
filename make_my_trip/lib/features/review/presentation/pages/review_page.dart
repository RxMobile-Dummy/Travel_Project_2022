import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/pages/review_shimmer_page.dart';
import 'package:make_my_trip/features/review/presentation/widgets/publish_review_slider_widget.dart';
import 'package:make_my_trip/features/review/presentation/widgets/review_card_widget.dart';
import 'package:make_my_trip/features/review/presentation/widgets/review_slider_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

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
          print(state);
          if (state is StateOnSuccess) {
            review = state.response;
            reviewModel = review?.review;
            print("object");
            print(review?.review);
            print(review?.hotelId);
          } else if (state is StateLoading || state is StateErrorGeneral) {
            return ReviewPageShimmer();
          }
          if (reviewModel!.length == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: Image.asset(
                      ImagePath.noDataFoundImage,
                    ),
                  ),
                  25.verticalSpace,
                  Text(
                    StringConstants.noHotelReview,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: MakeMyTripColors.accentColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: const BorderSide(
                                  color: MakeMyTripColors.color50gray)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: MakeMyTripColors.accentColor,
                                ),
                                Text(review!.hotelRating.toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "${reviewModel!.length} " + StringConstants.reviews,
                        style: const TextStyle(
                            color: MakeMyTripColors.color50gray),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reviewModel!.length,
                      itemBuilder: (context, index) {
                        return ReviewCardWidget(
                          date:
                              reviewModel![index].date?.substring(0, 10) ?? "",
                          name: reviewModel![index].userId?.userName ?? "Name",
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
        },
      ),
    );
  }
}
