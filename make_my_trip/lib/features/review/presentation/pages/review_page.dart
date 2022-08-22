import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/data/model/review_model.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/pages/review_shimmer_page.dart';
import 'package:make_my_trip/features/review/presentation/widgets/review_card_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({Key? key, required this.arg}) : super(key: key);
  Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    List<ReviewModel>? reviewModel;
    return BlocListener<ReviewCubit, BaseState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, RoutesName.publishReviewPage,
              arguments: {
                'context': context,
                'hotel_id': arg['hotel_id'],
                'rating': arg['rating']
              });
        } else {
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, RoutesName.login,
                arguments: {
                  "route_name": RoutesName.reviewPage,
                  'hotel_id': arg['hotel_id'],
                  'rating': arg['rating']
                });
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.reviews,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        body: BlocBuilder<ReviewCubit, BaseState>(
          builder: (context, state) {
            if (state is StateOnSuccess) {
              reviewModel = state.response;
            } else if (state is StateLoading) {
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
              return Column(
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
                                  size: 14,
                                  color: MakeMyTripColors.accentColor,
                                ),
                                Text(arg['rating'].toString()),
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
                  Expanded(
                    child: ListView.builder(
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
                          );
                        }),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              var searchState = context.read<ReviewCubit>().state;
              print(searchState);
              if (searchState is Authenticated) {
                Navigator.pushReplacementNamed(
                    context, RoutesName.publishReviewPage, arguments: {
                  'context': context,
                  'hotel_id': arg['hotel_id'],
                  'rating': arg['rating']
                });
              } else if (searchState is Unauthenticated) {
                Navigator.pushReplacementNamed(context, RoutesName.login,
                    arguments: {"route_name": RoutesName.reviewPage});
              } else {
                BlocProvider.of<ReviewCubit>(context).goToPostReview();
              }
            },
            backgroundColor: MakeMyTripColors.accentColor,
            child: const Icon(Icons.add)),
      ),
    );
  }
}
