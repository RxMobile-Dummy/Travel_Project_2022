import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/features/room_detail_page/presentation/pages/room_detail_shimmer.dart';
import 'package:make_my_trip/features/room_detail_page/presentation/widget/feture_item_widget.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

import '../manager/cubit/imageslider_cubit.dart';

class RoomDetailsPage extends StatelessWidget {
  RoomDetailsPage({Key? key,required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;
  RoomDetailModel? roomDetailsModel;
  int imgIndex = 0;
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagesliderCubit, BaseState>(builder: (context, state) {
      if (state is StateOnKnownToSuccess) {
        roomDetailsModel = state.response;
      } else if (state is StateOnResponseSuccess) {
        imgIndex = state.response;
      } else if (state is StateOnSuccess) {
        isReadMore = state.response;
      }else if (state is StateLoading){
        return const RoomDetailsShimmer();
      }
      else if (state is StateErrorGeneral) {
        return Scaffold(
            body: CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: StringConstants.serverFail,
              statusCode: state.errorMessage,
            ));
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
                  automaticallyImplyLeading: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Stack(fit: StackFit.expand, children: [
                      PageView.builder(
                        itemCount: roomDetailsModel!.images!.length,
                        onPageChanged: (index) {
                          BlocProvider.of<ImagesliderCubit>(context)
                              .onSwipeIndicator(index);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return FadeInImage.assetNetwork(

                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholder: 'assets/img/placeholder.png',
                              image: roomDetailsModel!.images![index].imageUrl ?? 'assets/img/placeholder.png',
                              imageErrorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                    'assets/img/placeholder.png',
                                    fit: BoxFit.fitWidth);
                              }) ;

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
                                    borderRadius: BorderRadius.circular(5.0)),
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
                                    "${roomDetailsModel?.images?.length} Photos",
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
                      Text(
                          " ${roomDetailsModel?.roomType ?? "Room type"} ${StringConstants.room}",
                          style: AppTextStyles.labelStyle.copyWith(fontSize: 24)),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      StringConstants.room_size,
                                      style: AppTextStyles.unselectedLabelStyle
                                          .copyWith(
                                          color: MakeMyTripColors.color50gray),
                                    ),
                                    3.verticalSpace,
                                    Text(
                                        roomDetailsModel?.roomSize ??
                                            "Room Size",
                                        style: AppTextStyles.unselectedLabelStyle)
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
                                        StringConstants.bedTxt,
                                        style: AppTextStyles.unselectedLabelStyle
                                            .copyWith(
                                            color:
                                            MakeMyTripColors.color50gray),
                                      ),
                                      3.verticalSpace,
                                      Text(
                                          roomDetailsModel?.bedSize ??
                                              "Bed Size",
                                          style: AppTextStyles.unselectedLabelStyle)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      10.verticalSpace,
                      Text(StringConstants.descriptionTxt,
                          style: AppTextStyles.labelStyle.copyWith(fontSize: 24)),
                      8.verticalSpace,
                      Text(
                        roomDetailsModel?.description ?? "Description",
                        textAlign: TextAlign.justify,
                        style: AppTextStyles.labelDescriptionStyle,
                      ),
                      20.verticalSpace,
                      Text(StringConstants.amenitiesTxt,
                          style: AppTextStyles.labelStyle.copyWith(fontSize: 24)),
                      10.verticalSpace,
                      Wrap(
                        children: [
                          FeaturesItemWidget(
                              text: roomDetailsModel?.features![0] ??
                                  "feature1"),
                          FeaturesItemWidget(
                              text: roomDetailsModel?.features![1] ??
                                  "feature2"),
                          FeaturesItemWidget(
                              text: roomDetailsModel?.features![2] ??
                                  "feature3"),
                          FeaturesItemWidget(
                              text: roomDetailsModel?.features![3] ??
                                  "feature3"),
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
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹ ${roomDetailsModel?.price?.toString()} p/night",
                  style: AppTextStyles.labelNameTextStyle.copyWith(
                      fontSize: 22, color: MakeMyTripColors.colorWhite),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: MakeMyTripColors.colorWhite),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(color: MakeMyTripColors.accentColor),
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}