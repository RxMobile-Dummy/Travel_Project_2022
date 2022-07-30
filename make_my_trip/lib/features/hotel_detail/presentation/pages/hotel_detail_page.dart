import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import 'package:make_my_trip/features/hotel_detail/presentation/pages/hotel_detail_shimmer.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
  HotelDetailModel? hotelDetailModel;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return BlocConsumer<HotelDetailCubit, BaseState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamed(context, RoutesName.login,
              arguments: {"route_name": RoutesName.hotelDetail});
        }
      },
      builder: (context, state) {
        if (state is StateOnKnownToSuccess) {
          hotelDetailModel = state.response;
          isLiked = hotelDetailModel!.isbookmark!;
        } else if (state is StateSearchResult) {
          isLiked = state.response;
        } else if (state is StateOnResponseSuccess) {
          imgIndex = state.response;
        } else if (state is StateOnSuccess) {
          isReadMore = state.response;
        } else if (state is StateLoading) {
          return const HotelDetailsShimmer();
        } else if (state is StateErrorGeneral) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: StringConstants.serverFail,
              statusCode: "");
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final scrolled =
                      constraints.scrollOffset > screen.height * .25;
                  return SliverAppBar(
                    backgroundColor: MakeMyTripColors.colorWhite,
                    expandedHeight: screen.height * .35,
                    elevation: 0,
                    excludeHeaderSemantics: true,
                    floating: true,
                    pinned: true,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: (Platform.isAndroid)
                            ? Icon(
                                Icons.arrow_back_outlined,
                                color: scrolled
                                    ? MakeMyTripColors.colorBlack
                                    : MakeMyTripColors.colorWhite,
                              )
                            : Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: scrolled
                                    ? MakeMyTripColors.colorBlack
                                    : MakeMyTripColors.colorWhite,
                              )),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<HotelDetailCubit>(context)
                              .onLikeTap(isLiked, hotelDetailModel!.id);
                        },
                        child: Icon(
                          (isLiked) ? Icons.favorite : Icons.favorite_border,
                          color: (isLiked)
                              ? MakeMyTripColors.colorRed
                              : (scrolled && !isLiked)
                                  ? MakeMyTripColors.colorBlack
                                  : MakeMyTripColors.colorWhite,
                          size: 28,
                        ),
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
                            return FadeInImage.assetNetwork(
                                placeholder: 'assets/img/placeholder.png',
                                image: hotelDetailModel
                                        ?.images![index].imageUrl ??
                                    "https://raw.githubusercontent.com/Nik7508/radixlearning/main/makemytrip/makemytrip/assets/images/hotel_img.png",
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/img/placeholder.png',
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
                                        "image_list": hotelDetailModel!.images
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
                                        "${hotelDetailModel?.images?.length} ${StringConstants.photos}",
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
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 20,
                      initialRating: hotelDetailModel?.rating?.toDouble() ?? 3,
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
                    Text(hotelDetailModel?.hotelName ?? "Hotel name",
                        style: AppTextStyles.labelStyle),
                    Row(
                      children: [
                        Text("₹ ${hotelDetailModel?.price?.toString()} /night"),
                        const Spacer(),
                        CircleIconButton(
                          isRotete: false,
                          iconData: Icons.call,
                          iconBtn: () async {
                            var url = Uri.parse(
                                "tel:${hotelDetailModel?.phoneNumber}");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch ';
                            }
                          },
                        )
                      ],
                    ),
                    12.verticalSpace,
                    Column(
                      children: [
                        Text(
                          hotelDetailModel?.description ?? "hotel description",
                          maxLines: (isReadMore) ? 10 : 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                        (hotelDetailModel?.description == null)
                            ? const SizedBox()
                            : Align(
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
                                          ? StringConstants.readLessTxt
                                          : StringConstants.readMoreTxt,
                                      style: const TextStyle(
                                          color: MakeMyTripColors.accentColor,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                    12.verticalSpace,
                    Wrap(
                      children: [
                        FeaturesItemWidget(
                            text:
                                hotelDetailModel?.features![0] ?? "feature 1"),
                        FeaturesItemWidget(
                            text:
                                hotelDetailModel?.features![1] ?? "feature 2"),
                        FeaturesItemWidget(
                            text:
                                hotelDetailModel?.features![2] ?? "feature 3"),
                        FeaturesItemWidget(
                            text:
                                hotelDetailModel?.features![3] ?? "feature 4"),
                      ],
                    ),
                    18.verticalSpace,
                    ReviewContainer(
                      icon: Icons.star_rounded,
                      leadingText: hotelDetailModel?.rating?.toString() ?? "3",
                      tralingText: StringConstants.seeAllReview,
                      onTap: () {
                        if (hotelDetailModel!.id != null) {
                          Navigator.pushNamed(context, RoutesName.reviewPage,
                              arguments: {
                                "hotel_id": hotelDetailModel!.id,
                                'rating': hotelDetailModel!.rating
                              });
                        }
                        // context.read<ReviewCubit>().getHotelReviewData(hotelDetailModel?.id);
                      },
                    ),
                    18.verticalSpace,
                    ReviewContainer(
                      leadingText: StringConstants.gallery,
                      tralingText: StringConstants.seeAllPhoto,
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.galleryPage,
                            arguments: {
                              "image_list": hotelDetailModel!.images
                            });
                      },
                    ),
                    18.verticalSpace,
                    Text(
                      StringConstants.location,
                      style: AppTextStyles.unselectedLabelStyle,
                    ),
                    12.verticalSpace,
                    Text(
                      hotelDetailModel?.address!.addressLine ??
                          "Hotel location",
                      maxLines: 2,
                      style: const TextStyle(
                        color: MakeMyTripColors.color70gray,
                      ),
                    ),
                    12.verticalSpace,
                    (hotelDetailModel != null)
                        ? LocationViewWidet(
                            log:
                                hotelDetailModel?.address?.location?.latitude ??
                                    10,
                            lat: hotelDetailModel
                                    ?.address?.location?.longitude ??
                                10,
                            titleName: hotelDetailModel?.hotelName! ?? "Hotel",
                            mapHeight: 200,
                          )
                        : SizedBox(),
                  ],
                )),
              )
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: CommonPrimaryButton(
                    text: StringConstants.selectRoom,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.calendar,
                          arguments: {'hotel_id': hotelDetailModel!.id});
                    })),
          ),
        );
      },
    );
  }
}
