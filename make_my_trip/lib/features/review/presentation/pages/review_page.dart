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
import 'package:make_my_trip/utils/constants/string_constants.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({Key? key, required this.arg}) : super(key: key);
  Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewCubit, BaseState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => true,arguments: {"route_name":RoutesName.publishReviewPage});
        }else if (state is Authenticated) {
          Navigator.pushNamed(
              context, RoutesName.publishReviewPage, arguments: {
            'context': context,
            'hotel_id': arg['hotel_id'],
            'rating': arg['rating']
          });
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
            print('this is my ${state}');
            if (state is StateOnSuccess) {
              List<ReviewModel> reviewModel = state.response;
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
                        "${reviewModel.length} " + StringConstants.reviews,
                        style: const TextStyle(
                            color: MakeMyTripColors.color50gray),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: reviewModel.length,
                        itemBuilder: (context, index) {
                          return ReviewCardWidget(
                            date:
                                reviewModel[index].date?.substring(0, 10) ?? "",
                            name: reviewModel[index].userId?.userName ?? "Name",
                            description:
                                reviewModel[index].comment ?? "Comments",
                            ratingValue: reviewModel[index].rating ?? 0.0,
                            image: reviewModel[index].userId?.userImage ??
                                "https://www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png",
                          );
                        }),
                  ),
                ],
              );
            } else if (state is StateLoading) {
              return ReviewPageShimmer();
            } else {
              return Center(
                child: Text('Data Not Found'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              var searchState = context.read<ReviewCubit>().state;
              print(searchState);
              if (searchState is StateOnSuccess<ReviewValueState>) {
    if(searchState.response.authenticated==false) {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => true,
          arguments: {"route_name": RoutesName.publishReviewPage});
    }
              } else if (searchState is StateOnSuccess<ReviewValueState>) {
                print('navi');
                if(searchState.response.authenticated==true) {
                  Navigator.pushNamed(
                      context, RoutesName.publishReviewPage, arguments: {
                    'context': context,
                    'hotel_id': arg['hotel_id'],
                    'rating': arg['rating']
                  });
                }
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
