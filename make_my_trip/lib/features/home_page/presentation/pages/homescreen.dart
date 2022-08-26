import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/view_full_coupon_page.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/coupon_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/imege_slidder_shimmer.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/navigation/route_info.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/widgets/common_error_widget.dart';
import '../cubit/homepage_cubit.dart';
import '../widgets/home_features_widget.dart';
import '../widgets/home_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageCubit, BaseState>(
        builder: (context, state) {
      print(state);
      if ((state is GettingStartedData &&
              state.imageLoading == false &&
              state.imageListValue == null) ||
          (state is GettingStartedData &&
              state.tourLoading == false &&
              state.toursListValue == null)) {
        return CommonErrorWidget(
          onTap: () {
            BlocProvider.of<HomepageCubit>(context)
              ..getToursApi()
              ..getImagesApi();
          },
        );
      } else {
        return Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              StringConstants.explorerTxt,
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            12.verticalSpace,
                            const Text(
                              StringConstants.weHopeTxt,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: MakeMyTripColors.color70gray),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        ImagePath.introImage3,
                        width: MediaQuery.of(context).size.width * .4,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.searchHotel,
                          arguments: {});
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                          hintText: StringConstants.searchTxt,
                          suffixIcon: Icon(Icons.search_rounded)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeFeaturesWidget(
                          iconData: Icons.hotel,
                          text: StringConstants.hotelTxt,
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.searchHotel,
                                arguments: {});
                          }),
                      HomeFeaturesWidget(
                          iconData: Icons.airplanemode_active_rounded,
                          text: StringConstants.flightTxt,
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "coming soon",
                                timeInSecForIosWeb: 4,
                                backgroundColor: MakeMyTripColors.colorBlack
                                    .withOpacity(.9));
                          }),
                      HomeFeaturesWidget(
                          iconData: Icons.maps_home_work,
                          text: StringConstants.placeTxt,
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "coming soon",
                                timeInSecForIosWeb: 4,
                                backgroundColor: MakeMyTripColors.colorBlack
                                    .withOpacity(.9));
                          }),
                      HomeFeaturesWidget(
                          iconData: Icons.place,
                          text: StringConstants.statesTxt,
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "coming soon",
                                timeInSecForIosWeb: 4,
                                backgroundColor: MakeMyTripColors.colorBlack
                                    .withOpacity(.9));
                          }),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        StringConstants.popularHotelsTxt,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.populer);
                        },
                        child: Row(
                          children: [
                            const Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: MakeMyTripColors.accentColor),
                            ),
                            4.horizontalSpace,
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: MakeMyTripColors.accentColor,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: (state is GettingStartedData)
                        ? (state.imageLoading == true)
                            ? const ImageSliderShimmer()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    state.imageListValue!.length, (index) {
                                  var imagelist =
                                      state.imageListValue?.toList();

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: HomeListWidget(
                                      rating:
                                          imagelist![index].rating.toString(),
                                      hotelName:
                                          imagelist[index].hotelName.toString(),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.searchHotel,
                                            arguments: {
                                              "hotel_id":
                                                  imagelist[index].hotelId,
                                              "hotel_name":
                                                  imagelist[index].hotelName,
                                              "share_link": false
                                            });
                                      },
                                      imageData: imagelist[index]
                                              .images![0]
                                              .imageUrl ??
                                          StringConstants.hotelImagePlaceHolder,
                                      address:
                                          imagelist[index].address!.addressLine,
                                    ),
                                  );
                                }))
                        : const ImageSliderShimmer()),
                16.verticalSpace,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    StringConstants.popularTourTxt,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: (state is GettingStartedData)
                        ? (state.tourLoading == true)
                            ? const ImageSliderShimmer()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    state.toursListValue!.length, (index) {
                                  var tourdata = state.toursListValue?[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: HomeListWidget(
                                      rating: tourdata!.rating.toString(),
                                      hotelName: tourdata.tourName.toString(),
                                      onTap: () {},
                                      imageData: tourdata.images![0].imageUrl ??
                                          StringConstants.hotelImagePlaceHolder,
                                    ),
                                  );
                                }))
                        : const ImageSliderShimmer()),
                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    StringConstants.attractiveOffers,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: ((state is GettingStartedData &&
                          state.couponListvalue != null)
                      ? (state.couponLoading == true)
                          ? const ImageSliderShimmer()
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  state.couponListvalue!.length,
                                  (index) {

                                var coupondata =
                                    state.couponListvalue![index];
                                print(coupondata.id);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ViewFullCoupon(
                                              discountText: coupondata.discount!.toString(),
                                              imgUrl: coupondata.couponImgUrl!,
                                              expiryDate: coupondata.endDate!,
                                              couponTitle:
                                                  coupondata.title!,
                                              couponCode:
                                                  coupondata.code!,
                                              couponDetails: coupondata
                                                  .description)));
                                    },
                                    child: CouponWidget(
                                      couponTitle: coupondata.title!,
                                      expiryDate: coupondata.endDate!,
                                      imgUrl:
                                          coupondata.couponImgUrl!,
                                      discountText:
                                          coupondata.discount!.toString(),
                                    ),
                                  ),
                                );
                              }))
                      : const ImageSliderShimmer()),
                ),
              ],
            ),
          ),
        ));
      }
    });
  }
}
