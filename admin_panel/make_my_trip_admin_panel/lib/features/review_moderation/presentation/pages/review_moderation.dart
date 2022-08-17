import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/data/models/review_model.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/presentation/cubit/review_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/review_moderation/review_moderation_injection_container.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

import '../../../../core/theme/text_styles.dart';

class ReviewModeration extends StatelessWidget {
  ReviewModeration({Key? key}) : super(key: key);

  final reviewCubit = reviewSl<ReviewModerationCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: MakeMyTripColors.accentColor.withOpacity(.2),
              )),
          Expanded(
            flex: 8,
            child: BlocBuilder<ReviewModerationCubit, BaseState>(
              bloc: reviewCubit,
              builder: (context, state) {
                if (state is StateErrorGeneralStateErrorServer) {
                  return const Text("Server Error");
                } else if (state is StateErrorGeneral) {
                  return Text(state.errorMessage);
                } else if (state is StateOnSuccess) {
                  List<ReviewModel> reviewModel = state.response;
                  return Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: reviewModel.length,
                        itemBuilder: (context, listIndex) {
                          return Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MakeMyTripColors.color10gray),
                                borderRadius: BorderRadius.circular(12)),
                            // child: Row(
                            //   children: [
                            //     Text(model.id!.toString()),
                            //     CommonPrimaryButton(text: "Approved", onTap: onTap),
                            //     CommonPrimaryButton(text: "Reject", onTap: onRemove)
                            //   ],
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 12, bottom: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              "https://lh3.googleusercontent.com/a/AItbvmm7d_MlCoMQqiTsWLEYYDkM9jvuARcXFB4Wg1b8=s96-c",
                                              width: 32,
                                            ),
                                            12.horizontalSpace,
                                            Text(
                                              reviewModel[listIndex]
                                                  .userId!
                                                  .userName!,
                                              style: AppTextStyles
                                                  .infoContentStyle4
                                                  .copyWith(
                                                      color: MakeMyTripColors
                                                          .colorBlack),
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
                                                text: "Approve",
                                                onTap: () {
                                                  reviewCubit
                                                      .approveOrRejectCubit(
                                                          reviewModel[listIndex]
                                                              .id!,
                                                          true);
                                                },
                                                backColor: Colors.green,
                                              ),
                                            ),
                                            12.horizontalSpace,
                                            Expanded(
                                              child: CommonPrimaryButton(
                                                text: "Reject",
                                                onTap: () {
                                                  reviewCubit
                                                      .approveOrRejectCubit(
                                                          reviewModel[listIndex]
                                                              .id!,
                                                          false);
                                                },
                                                backColor:
                                                    MakeMyTripColors.colorRed,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 12),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          reviewModel[listIndex].comment!,
                                          style: AppTextStyles
                                              .labelDescriptionStyle
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: MakeMyTripColors
                                                      .colorBlack),
                                        ),
                                        4.verticalSpace,
                                        TextButton.icon(
                                          icon: (!reviewCubit.showImages)
                                              ? const Icon(
                                                  Icons.arrow_right_rounded)
                                              : const Icon(Icons
                                                  .arrow_drop_down_rounded),
                                          onPressed: () {
                                            reviewCubit.viewImages(
                                                !reviewCubit.showImages);
                                          },
                                          label: Text(
                                            "View images",
                                            style: AppTextStyles
                                                .infoContentStyle4
                                                .copyWith(
                                                    color: MakeMyTripColors
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                        8.verticalSpace,
                                        Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: List.generate(
                                              reviewModel[listIndex]
                                                  .image!
                                                  .length,
                                              (index1) => Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          reviewModel[listIndex]
                                                              .image![index1]
                                                              .imageUrl!,
                                                          fit: BoxFit.cover,
                                                          width: 100,
                                                          height: 100,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          reviewCubit.reviewImageDeleteCubit(
                                                              reviewModel[
                                                                      listIndex]
                                                                  .id!,
                                                              reviewModel[
                                                                      listIndex]
                                                                  .image![
                                                                      index1]
                                                                  .imageId!);
                                                        },
                                                        child: const Positioned(
                                                          top: 8,
                                                          right: 8,
                                                          child: Icon(
                                                            Icons.cancel,
                                                            color:
                                                                MakeMyTripColors
                                                                    .colorWhite,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ));
                } else {
                  return const Center(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class ReviewContainer extends StatelessWidget {
//   const ReviewContainer({
//     Key? key,
//     required this.model,
//     required this.onTap,
//     required this.onRemove,
//     required this.onImageDelete,
//   }) : super(key: key);

//   final ReviewModel model;
//   final VoidCallback onTap, onRemove, onImageDelete;
//   @override
//   Widget build(BuildContext context) {
//     debugPrint(model.userId!.userImage!);
//     return 
//   }
// }
