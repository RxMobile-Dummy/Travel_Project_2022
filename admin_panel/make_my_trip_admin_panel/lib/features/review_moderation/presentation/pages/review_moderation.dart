import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/presentation/cubit/review_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/review_moderation_injection_container.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_error_widget.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';
import '../../../../core/theme/text_styles.dart';

class ReviewModeration extends StatelessWidget {
  ReviewModeration({Key? key}) : super(key: key);

  final reviewCubit = reviewSl<ReviewModerationCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.reviewAppbarTitle),
        ),
        body: BlocBuilder<ReviewModerationCubit, BaseState>(
          bloc: reviewCubit,
          builder: (context, state) {
            if (state is StateErrorGeneralStateErrorServer) {
              return CommonErrorWidget(
                onTap: () {
                  reviewCubit.getAllReviewsCubit();
                },
              );
            } else if (state is StateOnSuccess) {
              List<ReviewModel> reviewModel = state.response;
              return (reviewModel.isEmpty)
                  ? const CommonErrorWidget(
                      imagePath: ImagePath.emptyFailureImg,
                      statusCode: StringConstants.noResultsTxt,
                      title: StringConstants.noReviewsTxt,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: reviewModel.length,
                        itemBuilder: (context, listIndex) {
                          if (reviewModel != null) {
                            return ReviewContainerWidget(
                                reviewModel: reviewModel[listIndex],
                                reviewCubit: reviewCubit);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class ReviewContainerWidget extends StatelessWidget {
  const ReviewContainerWidget({
    Key? key,
    required this.reviewModel,
    required this.reviewCubit,
  }) : super(key: key);

  final ReviewModel reviewModel;
  final ReviewModerationCubit reviewCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: MakeMyTripColors.color10gray),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: FadeInImage.assetNetwork(
                            placeholder: ImagePath.userDefaultImg,
                            image: reviewModel.userId!.userImage!,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImagePath.userDefaultImg,
                                fit: BoxFit.cover,
                                width: 36,
                                height: 36,
                              );
                            },
                          )),
                      12.horizontalSpace,
                      Text(
                        reviewModel.userId!.userName ?? "sdf",
                        style: AppTextStyles.infoContentStyle4
                            .copyWith(color: MakeMyTripColors.colorBlack),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonPrimaryButton(
                          text: StringConstants.approveTxt,
                          onTap: () {
                            reviewCubit.approveOrRejectCubit(
                                reviewModel.id ?? 1, true);
                          },
                          backColor: Colors.green,
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: CommonPrimaryButton(
                          text: StringConstants.rejectTxt,
                          onTap: () {
                            reviewCubit.approveOrRejectCubit(
                                reviewModel.id ?? 1, false);
                          },
                          backColor: MakeMyTripColors.colorRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: MakeMyTripColors.color10gray),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.store_mall_directory_rounded,
                          size: 18,
                          color: MakeMyTripColors.colorBlack.withOpacity(.7),
                        ),
                        4.horizontalSpace,
                        Text(reviewModel.hotelId!.hotelName ?? "hotelname"),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: MakeMyTripColors.color10gray),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      reviewModel.comment! ?? "",
                      style: AppTextStyles.labelDescriptionStyle.copyWith(
                          fontSize: 14, color: MakeMyTripColors.colorBlack),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      ReviewSliderWidget(
                          title: StringConstants.cleanlinessTxt,
                          value: reviewModel.cleanliness ?? 0),
                      ReviewSliderWidget(
                          title: StringConstants.comfortTxt,
                          value: reviewModel.comfort ?? 0),
                      ReviewSliderWidget(
                          title: StringConstants.facilitiesTxt,
                          value: reviewModel.facilities ?? 0),
                      ReviewSliderWidget(
                          title: StringConstants.locationTxt,
                          value: reviewModel.location ?? 0)
                    ],
                  ),
                  8.verticalSpace,
                  reviewModel.image!.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: MakeMyTripColors.color10gray),
                              borderRadius: BorderRadius.circular(12)),
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              reviewModel.image!.length,
                              (index1) => Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: ImagePath.imagePlaceholder,
                                        image: reviewModel
                                            .image![index1].imageUrl!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            ImagePath.imagePlaceholder,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          );
                                        },
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      reviewCubit.reviewImageDeleteCubit(
                                          reviewModel.id ?? 0,
                                          reviewModel.image![index1].imageId ??
                                              0);
                                    },
                                    child: const Positioned(
                                      top: 8,
                                      right: 12,
                                      child: Icon(
                                        Icons.cancel,
                                        color: MakeMyTripColors.colorWhite,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReviewSliderWidget extends StatelessWidget {
  const ReviewSliderWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: MakeMyTripColors.accentColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Text(
            "$title  $value",
            style: AppTextStyles.infoContentStyle4.copyWith(
                color: MakeMyTripColors.colorBlack,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
          4.horizontalSpace,
          const Icon(
            Icons.star,
            size: 18,
          )
        ],
      ),
    );
  }
}
