import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/features/room_detail_page/presentation/widget/feture_item_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../manager/cubit/imageslider_cubit.dart';

class RoomDetailsPage extends StatelessWidget {
  RoomDetailsPage({Key? key}) : super(key: key);

  final List<String> imgList = [
    ImagePath.imagecenter,
    ImagePath.imagecenter2,
    ImagePath.imagecenter3

  ];
  RoomDetailsModel? roomDetailsModel;
  int imgIndex = 0;
  bool isReadMore = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesliderCubit, BaseState>(
        builder: (context, state) {
          if (state is StateOnKnownToSuccess) {
            roomDetailsModel = state.response;
          } else if (state is StateOnResponseSuccess) {
            imgIndex = state.response;
          } else if (state is StateOnSuccess) {
            isReadMore = state.response;
          }
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
                                : MakeMyTripColors.colorBlue,
                          ),
                          label: const Text("Back",
                            style: AppTextStyles.infoContentStyle4,
                          )),
                      leadingWidth: 100,
                      title:  Text(roomDetailsModel?.roomData?.roomType ?? "Room Type",
                          style: AppTextStyles.confirmButtonTextStyle),
                      actions: [
                        Icon(Icons.settings,color: scrolled
                            ? MakeMyTripColors.colorBlack
                            : MakeMyTripColors.colorBlue,),
                        12.horizontalSpace,
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Stack(fit: StackFit.expand, children: [
                          PageView.builder(
                            itemCount: 4,
                            onPageChanged: (index) {
                              BlocProvider.of<ImagesliderCubit>(context)
                                  .onSwipeIndicator(index);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                roomDetailsModel?.roomImage![index].imageUrl ??
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
                                DotsIndicator(
                                  dotsCount: 4,
                                  position: imgIndex.toDouble(),
                                  decorator: DotsDecorator(
                                    activeSize: const Size(9.0, 9.0),
                                    activeColor: MakeMyTripColors.accentColor,
                                    color: MakeMyTripColors.colorBlack,
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: MakeMyTripColors.colorWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${roomDetailsModel?.roomImage?.length} Photos",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: MakeMyTripColors.color10gray,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          StringConstants.room_size,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: MakeMyTripColors.color70gray),
                                        ),
                                        3.verticalSpace,
                                        Text(
                                          roomDetailsModel?.roomData?.roomSize ??
                                              "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 70,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: MakeMyTripColors.color10gray,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            StringConstants.bed,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: MakeMyTripColors.color70gray),
                                          ),
                                          3.verticalSpace,
                                          Text(
                                              roomDetailsModel?.roomData?.bedSize ??
                                                  "",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          Text(
                            StringConstants.description,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          8.verticalSpace,
                          Text(
                            roomDetailsModel?.roomData?.description ?? "",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 15),
                          ),
                          20.verticalSpace,
                          Text(
                            StringConstants.amenities,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          10.verticalSpace,

                          Wrap(
                            children: [
                              FeaturesItemWidget(
                                  text: roomDetailsModel?.roomData
                                      ?.features![0] ?? ""),
                              FeaturesItemWidget(
                                  text: roomDetailsModel?.roomData
                                      ?.features![1] ?? ""),
                              FeaturesItemWidget(
                                  text: roomDetailsModel?.roomData
                                      ?.features![2] ?? ""),
                              FeaturesItemWidget(
                                  text: roomDetailsModel?.roomData
                                      ?.features![3] ?? "" ),
                            ],
                          ),

                        ],
                      )),
                )
              ],
            ),
              bottomNavigationBar: Container(
                color: MakeMyTripColors.accentColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 20.0,top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹ ${roomDetailsModel?.roomData?.price?.toString()} p/night",
                        style: AppTextStyles.labelNameTextStyle.copyWith(fontSize: 22,color: MakeMyTripColors.colorWhite),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            print(roomDetailsModel?.roomData?.price?.toString());
                          },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),primary: MakeMyTripColors.colorWhite
                          ),
                          child: const Text('Book Now',style: TextStyle(color: MakeMyTripColors.accentColor),))
                    ],
                  ),
                ),
              ),

          );
        });
  }
}

Widget amenities(String image, String title) {
  return Container(
    height: 100,
    width: 170,
    decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: MakeMyTripColors.color0gray,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        )),
    child: Column(
      children: [
        const Expanded(child: const SizedBox()),
        Container(
            decoration: const BoxDecoration(
              color: MakeMyTripColors.color10gray,
              borderRadius: const BorderRadius.only(
                  bottomLeft: const Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            height: 20,
            width: double.infinity,
            child: Center(
                child: Text(
              title,
              style: const TextStyle(color: MakeMyTripColors.colorBlack),
            )))
      ],
    ),
  );
}
