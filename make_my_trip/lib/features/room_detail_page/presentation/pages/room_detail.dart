import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/widgets/features_item_widget.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_categories_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/select_room_count.dart';
import 'package:make_my_trip/features/room_detail_page/data/model/room_detail_model.dart';
import 'package:make_my_trip/features/room_detail_page/presentation/pages/room_detail_shimmer.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

import '../manager/cubit/imageslider_cubit.dart';

class RoomDetailsPage extends StatelessWidget {
  RoomDetailsPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;
  RoomDetailModel? roomDetailsModel;
  int imgIndex = 0;
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    List<RoomType>? roomType;
    int? noOfRoom;
    if (arg['room_list_model'] != null) {
      roomType = arg['room_list_model'];
      noOfRoom = arg['no_of_room'] == 0 ? 1 : arg['no_of_room'];
    }
    var roomMaxLength = roomType!.length;
    var snackBar =
        SnackBar(content: Text('No Room Selected, Pls First Select Room'));
    return BlocConsumer<ImagesliderCubit, BaseState>(
  listener: (context, state) {
    if (state is Unauthenticated) {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => true,arguments: {"route_name":RoutesName.bookingPage});
    } else if (state is Authenticated) {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.bookingPage, (route) => true);
    }
  },
  builder: (context, state) {

      if (state is StateOnKnownToSuccess) {
        roomDetailsModel = state.response;
      } else if (state is StateOnResponseSuccess) {
        imgIndex = state.response;
      } else if (state is StateOnSuccess) {
        isReadMore = state.response;
      } else if (state is StateLoading) {
        return const RoomDetailsShimmer();
      } else if (state is StateErrorGeneral) {
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
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: scrolled
                          ? MakeMyTripColors.colorBlack
                          : MakeMyTripColors.colorWhite,
                    ),
                  ),
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
                              image:
                                  roomDetailsModel!.images![index].imageUrl ??
                                      'assets/img/placeholder.png',
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/img/placeholder.png',
                                    fit: BoxFit.fitWidth);
                              });
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.galleryPage,
                                    arguments: {
                                      "image_list": roomDetailsModel!.images
                                    });
                              },
                              child: Container(
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
                                          fontSize: 18,
                                          color: MakeMyTripColors.color50gray),
                                ),
                                3.verticalSpace,
                                Text(roomDetailsModel?.roomSize ?? "Room Size",
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
                                            fontSize: 18,
                                            color:
                                                MakeMyTripColors.color50gray),
                                  ),
                                  3.verticalSpace,
                                  Text(roomDetailsModel?.bedSize ?? "Bed Size",
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
                    roomDetailsModel?.description ?? "room description",
                    textAlign: TextAlign.justify,
                  ),
                  20.verticalSpace,
                  Text(StringConstants.amenitiesTxt,
                      style: AppTextStyles.labelStyle.copyWith(fontSize: 24)),
                  10.verticalSpace,
                  Wrap(
                    children: [
                      FeaturesItemWidget(
                          text: roomDetailsModel?.features![0] ?? "feature1"),
                      FeaturesItemWidget(
                          text: roomDetailsModel?.features![1] ?? "feature2"),
                      FeaturesItemWidget(
                          text: roomDetailsModel?.features![2] ?? "feature3"),
                      FeaturesItemWidget(
                          text: roomDetailsModel?.features![3] ?? "feature3"),
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
            child: BlocBuilder<SelectRoomCountCubit, BaseState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('remove');
                        if (state is StateOnSuccess<SelectRoomCountState>) {
                          context.read<SelectRoomCountCubit>().removeRoomEvent(
                              roomDetailsModel!.roomType!,
                              roomDetailsModel!.roomType == "Deluxe"
                                  ? state.response.deluxValue
                                  : (roomDetailsModel!.roomType == "Semi-Deluxe"
                                      ? state.response.semiDeluxValue
                                      : (roomDetailsModel!.roomType ==
                                              "Super-Deluxe"
                                          ? state.response.superDeluxValue
                                          : int.parse(noOfRoom.toString()))));
                        }
                      },
                      // roomRemoveOnTap,
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Icon(
                              Icons.square_rounded,
                              size: 25,
                              color: MakeMyTripColors.colorWhite,
                            ),
                            Icon(
                              Icons.remove,
                              size: 20,
                              color: MakeMyTripColors.accentColor,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        state is StateOnSuccess<SelectRoomCountState>
                            ? (roomDetailsModel!.roomType == "Deluxe"
                                ? state.response.deluxValue.toString()
                                : (roomDetailsModel!.roomType == "Semi-Deluxe"
                                    ? state.response.semiDeluxValue.toString()
                                    : (roomDetailsModel!.roomType ==
                                            "Super-Deluxe"
                                        ? state.response.superDeluxValue
                                            .toString()
                                        : "0")))
                            : "0",
                        style: AppTextStyles.infoContentStyle
                            .copyWith(color: MakeMyTripColors.colorWhite),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (state is StateOnSuccess<SelectRoomCountState>) {
                          context.read<SelectRoomCountCubit>().addRoomEvent(
                              roomDetailsModel!.roomType!,
                              roomDetailsModel!.roomType == "Deluxe"
                                  ? state.response.deluxValue
                                  : (roomDetailsModel!.roomType == "Semi-Deluxe"
                                      ? state.response.semiDeluxValue
                                      : (roomDetailsModel!.roomType ==
                                              "Super-Deluxe"
                                          ? state.response.superDeluxValue
                                          : int.parse(noOfRoom.toString()))),
                              roomMaxLength);
                        }
                      },
                      // roomAddOnTap,
                      child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: const [
                            Icon(
                              Icons.square_rounded,
                              size: 25,
                              color: MakeMyTripColors.colorWhite,
                            ),
                            Icon(
                              Icons.add,
                              size: 20,
                              color: MakeMyTripColors.accentColor,
                            ),
                          ]),
                    ),
                    const Spacer(),
                    Text(
                      "₹ ${((int.parse(roomDetailsModel!.price.toString()) * (state is StateOnSuccess<SelectRoomCountState> ? (roomDetailsModel!.roomType == "Deluxe" ? (state.response.deluxValue == 0 ? 1 : state.response.deluxValue) : (roomDetailsModel!.roomType == "Semi-Deluxe" ? (state.response.semiDeluxValue == 0 ? 1 : state.response.semiDeluxValue) : (roomDetailsModel!.roomType == "Super-Deluxe" ? (state.response.superDeluxValue == 0 ? 1 : state.response.superDeluxValue) : 1))) : 1)).toString())}",
                      style: AppTextStyles.labelNameTextStyle.copyWith(
                          fontSize: 22, color: MakeMyTripColors.colorWhite),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          // state is StateOnSuccess<SelectRoomCountState>
                          //     ? ((roomDetailsModel!.roomType == "Deluxe"
                          //                 ? state.response.deluxValue
                          //                 : (roomDetailsModel!.roomType ==
                          //                         "Semi-Deluxe"
                          //                     ? state.response.semiDeluxValue
                          //                     : (roomDetailsModel!.roomType ==
                          //                             "Super-Deluxe"
                          //                         ? state
                          //                             .response.superDeluxValue
                          //                         : 0))) >
                          //             0
                          //         ? Navigator.pushNamed(
                          //             context, RoutesName.bookingPage)
                          //         : ScaffoldMessenger.of(context)
                          //             .showSnackBar(snackBar))
                          //     : null;

                          if(state is StateOnSuccess<SelectRoomCountState>){
                            if((roomDetailsModel!.roomType == "Deluxe"
                                ? state.response.deluxValue
                                : (roomDetailsModel!.roomType ==
                                "Semi-Deluxe"
                                ? state.response.semiDeluxValue
                                : (roomDetailsModel!.roomType ==
                                "Super-Deluxe"
                                ? state
                                .response.superDeluxValue
                                : 0)))>0){
                              var searchState = context.read<ImagesliderCubit>().state;
                              if (searchState is Unauthenticated) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, RoutesName.login, (route) => true,arguments: {"route_name":RoutesName.bookingPage});
                              } else{
                                BlocProvider.of<ImagesliderCubit>(context).goToBooking();
                              }

                            }else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: MakeMyTripColors.colorWhite),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                              color:
                                  (state is StateOnSuccess<SelectRoomCountState>
                                          ? ((roomDetailsModel!.roomType ==
                                                      "Deluxe"
                                                  ? state.response.deluxValue
                                                  : (roomDetailsModel!
                                                              .roomType ==
                                                          "Semi-Deluxe"
                                                      ? state.response
                                                          .semiDeluxValue
                                                      : (roomDetailsModel!
                                                                  .roomType ==
                                                              "Super-Deluxe"
                                                          ? state.response
                                                              .superDeluxValue
                                                          : 0))) >
                                              0)
                                          : false)
                                      ? MakeMyTripColors.accentColor
                                      : MakeMyTripColors.color30gray),
                        ))
                  ],
                );
              },
            ),
          ),
        ),
      );

  },
);
  }
}
