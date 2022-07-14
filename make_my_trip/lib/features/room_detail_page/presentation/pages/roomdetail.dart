import 'package:carousel_slider/carousel_slider.dart';
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
  var val = 0;
  RoomDetailsModel? roomDetailsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesliderCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnResponseSuccess) {
          roomDetailsModel = state.response;
        } else if (state is StateOnSuccess) {
          val = state.response;
        }
        return Scaffold(
            bottomNavigationBar: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MakeMyTripColors.colorBlack,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      roomDetailsModel?.roomData?.price?.toString() ?? "",
                      style: AppTextStyles.infoContentStyle3,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(roomDetailsModel?.roomData?.price?.toString());
                        },
                        child: Text(StringConstants.continue_button,
                            style: AppTextStyles.infoContentStyle3))
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 280,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          // autoPlay: false,
                          onPageChanged: (i, r) {
                            BlocProvider.of<ImagesliderCubit>(context)
                                .getindex(i);
                          }),
                      items: imgList
                          .map((item) => Container(
                                child: Center(
                                    child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  height: 280,
                                  width: double.infinity,
                                )),
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 280,
                      child: Column(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 35.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_back_ios_outlined,
                                          size: 18,
                                          color: MakeMyTripColors.colorWhite,
                                        ),
                                        Text(
                                          StringConstants.back,
                                          style:
                                              AppTextStyles.infoContentStyle5,
                                        )
                                      ],
                                    ),
                                    Text(
                                        roomDetailsModel
                                                ?.roomData?.roomType ??
                                            "",
                                        style: AppTextStyles
                                            .confirmButtonTextStyle),
                                    const Icon(
                                      Icons.settings,
                                      size: 20,
                                      color: MakeMyTripColors.colorWhite,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              child: AnimatedSmoothIndicator(
                                activeIndex: val,
                                count: imgList.length,
                                effect: const ExpandingDotsEffect(
                                    dotColor: MakeMyTripColors.colorWhite,
                                    activeDotColor:
                                        MakeMyTripColors.colorBlue,
                                    dotWidth: 8,
                                    dotHeight: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 10),
                    child: Text(
                      StringConstants.description,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 12.0, bottom: 10, right: 12.0),
                    child: Text(
                      roomDetailsModel?.roomData?.description ?? "",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      StringConstants.amenities,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         amenities(ImagePath.demoroom,
                  //             roomDetailsModel?.roomData?.features?[0] ?? ""),
                  //         const SizedBox(
                  //           height: 15,
                  //         ),
                  //         amenities(ImagePath.tv,
                  //             roomDetailsModel?.roomData?.features?[1] ?? "")
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         amenities(ImagePath.wifi,
                  //             roomDetailsModel?.roomData?.features?[3] ?? ""),
                  //         const SizedBox(
                  //           height: 15,
                  //         ),
                  //         amenities(ImagePath.ac,
                  //             roomDetailsModel?.roomData?.features?[4] ?? ""),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        FeaturesItemWidget(
                            text: roomDetailsModel?.roomData?.features?[0] ?? ""),
                        FeaturesItemWidget(
                            text: roomDetailsModel?.roomData?.features?[1] ?? ""),
                        FeaturesItemWidget(
                            text: roomDetailsModel?.roomData?.features?[2] ?? ""),
                        FeaturesItemWidget(
                            text: roomDetailsModel?.roomData?.features?[3] ?? ""),
                      ],
                    ),
                  ),

                  20.verticalSpace,
                ],
              ),
            ));
      },
    );
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
