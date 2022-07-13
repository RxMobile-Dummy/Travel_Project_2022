import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../widgets/circle_icon_button.dart';
import '../widgets/features_item_widget.dart';
import '../widgets/loaction_widget.dart';
import '../widgets/review_container.dart';

class HotelDetailPage extends StatelessWidget {
  HotelDetailPage({Key? key}) : super(key: key);

  bool isLiked = false;
  bool isReadMore = false;
  int imgIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final scrolled = constraints.scrollOffset > 200;
              return SliverAppBar(
                backgroundColor: MakeMyTripColors.colorWhite,
                expandedHeight: 280.0,
                elevation: 0,
                excludeHeaderSemantics: true,
                floating: true,
                pinned: true,
                leading: TextButton.icon(
                    onPressed: () {
                      debugPrint("back");
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: scrolled
                          ? MakeMyTripColors.colorBlack
                          : MakeMyTripColors.colorWhite,
                    ),
                    label: Text(
                      StringConstants.backBtn,
                      style: TextStyle(
                          color: scrolled
                              ? MakeMyTripColors.colorBlack
                              : MakeMyTripColors.colorWhite,
                          fontSize: 18),
                    )),
                leadingWidth: 100,
                actions: [
                  BlocBuilder<HotelDetailCubit, BaseState>(
                    builder: (context, state) {
                      (state is StateSearchResult)
                          ? isLiked = state.response
                          : false;
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<HotelDetailCubit>(context)
                              .onLikeTap(isLiked);
                        },
                        child: Icon(
                          (isLiked)
                              ? Icons.heart_broken
                              : Icons.heart_broken_outlined,
                          color: (isLiked)
                              ? MakeMyTripColors.colorRed
                              : (scrolled && !isLiked)
                                  ? MakeMyTripColors.colorBlack
                                  : MakeMyTripColors.colorWhite,
                        ),
                      );
                    },
                  ),
                  12.horizontalSpace,
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(fit: StackFit.expand, children: [
                    PageView.builder(
                      itemCount: 4,
                      onPageChanged: (index) {
                        BlocProvider.of<HotelDetailCubit>(context)
                            .onSwipeIndicator(index);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          "https://raw.githubusercontent.com/Nik7508/radixlearning/main/makemytrip/makemytrip/assets/images/hotel_img.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 10, left: 10),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<HotelDetailCubit, BaseState>(
                            builder: (context, state) {
                              if (state is StateOnResponseSuccess) {
                                imgIndex = state.response;
                              }
                              return DotsIndicator(
                                dotsCount: 4,
                                position: imgIndex.toDouble(),
                                decorator: DotsDecorator(
                                  activeSize: const Size(9.0, 9.0),
                                  activeColor: MakeMyTripColors.accentColor,
                                  color: MakeMyTripColors.colorBlack,
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                              );
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MakeMyTripColors.colorWhite,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "34 ${StringConstants.photos}",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                8.horizontalSpace,
                                const Icon(Icons.image)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
                delegate: SliverChildListDelegate(
              [
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 20,
                  initialRating: 4,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: MakeMyTripColors.accentColor,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                12.verticalSpace,
                const Text("Four Seasons Resort Chiang Mai",
                    style: AppTextStyles.labelStyle),
                Expanded(
                  child: Row(
                    children: [
                      const Text("\$75 p/night"),
                      const Spacer(),
                      const CircleIconButton(
                        isRotete: true,
                        iconData: Icons.navigation_rounded,
                      ),
                      12.horizontalSpace,
                      const CircleIconButton(
                        isRotete: false,
                        iconData: Icons.call,
                      )
                    ],
                  ),
                ),
                12.verticalSpace,
                BlocBuilder<HotelDetailCubit, BaseState>(
                  builder: (context, state) {
                    (state is StateOnSuccess)
                        ? isReadMore = state.response
                        : false;
                    return Column(
                      children: [
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          maxLines: (isReadMore) ? 10 : 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<HotelDetailCubit>(context)
                                  .onReadMoreTap(isReadMore);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                (isReadMore)
                                    ? StringConstants.readLess
                                    : StringConstants.readMore,
                                style: const TextStyle(
                                    color: MakeMyTripColors.accentColor,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                12.verticalSpace,
                Wrap(
                  children: const [
                    FeaturesItemWidget(text: "Parking"),
                    FeaturesItemWidget(text: "Free Wifi"),
                    FeaturesItemWidget(text: "Spa"),
                    FeaturesItemWidget(text: "Airport Transfer"),
                  ],
                ),
                18.verticalSpace,
                ReviewContainer(
                  icon: Icons.star_rounded,
                  leadingText: "3.5",
                  tralingText: StringConstants.seeAllReview,
                ),
                18.verticalSpace,
                ReviewContainer(
                  leadingText: StringConstants.gallery,
                  tralingText: StringConstants.seeAllReview,
                ),
                18.verticalSpace,
                const Text(
                  "Location",
                  style: AppTextStyles.unselectedLabelStyle,
                ),
                12.verticalSpace,
                const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  maxLines: 2,
                  style: TextStyle(
                    color: MakeMyTripColors.color70gray,
                  ),
                ),
                12.verticalSpace,
                const LocationViewWidet(),
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              StringConstants.selectRoom,
              style: AppTextStyles.confirmButtonTextStyle,
            ),
            style: ElevatedButton.styleFrom(
              primary: MakeMyTripColors.accentColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
    );
  }
}
