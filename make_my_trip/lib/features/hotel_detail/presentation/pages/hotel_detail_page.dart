import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_state.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final scrolled = constraints.scrollOffset > 200;
              return SliverAppBar(
                backgroundColor: Colors.white,
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
                      color: scrolled ? Colors.black : Colors.white,
                    ),
                    label: Text(
                      StringConstants.backBtn,
                      style: TextStyle(
                          color: scrolled ? Colors.black : Colors.white,
                          fontSize: 18),
                    )),
                leadingWidth: 100,
                actions: [
                  BlocBuilder<HotelDetailCubit, HotelDetailState>(
                    builder: (context, state) {
                      (state is HotelDetailIsLikeState)
                          ? isLiked = state.isLiked
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
                              ? Colors.red
                              : (scrolled && !isLiked)
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  )
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
                          BlocBuilder<HotelDetailCubit, HotelDetailState>(
                            builder: (context, state) {
                              if (state is HotelDetailIndicatorIndexState) {
                                imgIndex = state.index;
                                print(imgIndex);
                              }
                              return DotsIndicator(
                                dotsCount: 4,
                                position: imgIndex.toDouble(),
                                decorator: DotsDecorator(
                                  activeSize: const Size(9.0, 9.0),
                                  activeColor: Colors.blue,
                                  color: Colors.black,
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
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "34 ${StringConstants.photos}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.image)
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
                    color: Colors.blue,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Four Seasons Resort Chiang Mai",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Row(
                    children: const [
                      Text("\$75 p/night"),
                      Spacer(),
                      CircleIconButton(
                        isRotete: true,
                        iconData: Icons.navigation_rounded,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      CircleIconButton(
                        isRotete: false,
                        iconData: Icons.call,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<HotelDetailCubit, HotelDetailState>(
                  builder: (context, state) {
                    (state is HotelDetailIsReadMoreState)
                        ? isReadMore = state.isReadMore
                        : false;
                    return Column(
                      children: [
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          maxLines: (isReadMore) ? 10 : 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<HotelDetailCubit>(context)
                                  .onReadMoreTap(isReadMore);
                            },
                            child: Text(
                              (isReadMore) ? "read less" : "read More",
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Wrap(
                  children: const [
                    FeaturesItemWidget(text: "Parking"),
                    FeaturesItemWidget(text: "Free Wifi"),
                    FeaturesItemWidget(text: "Spa"),
                    FeaturesItemWidget(text: "Airport Transfer"),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const ReviewContainer(
                  icon: Icons.star_rounded,
                  leadingText: "3.5",
                  tralingText: "See all reviews",
                ),
                const SizedBox(
                  height: 18,
                ),
                const ReviewContainer(
                  leadingText: "Gallery",
                  tralingText: "See all reviews",
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 12,
                ),
                const LocationViewWidet(),
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Select Room",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18)),
        ),
      ),
    );
  }
}
