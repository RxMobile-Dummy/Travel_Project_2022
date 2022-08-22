import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (state is StateErrorGeneral) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              title: StringConstants.serverFail,
              statusCode: "");
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
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
                              Navigator.pushNamed(
                                  context, RoutesName.searchHotel,
                                  arguments: {});
                            }),
                        HomeFeaturesWidget(
                            iconData: Icons.airplanemode_active_rounded,
                            text: StringConstants.flightTxt,
                            onTap: () {}),
                        HomeFeaturesWidget(
                            iconData: Icons.maps_home_work,
                            text: StringConstants.placeTxt,
                            onTap: () {}),
                        HomeFeaturesWidget(
                            iconData: Icons.place,
                            text: StringConstants.statesTxt,
                            onTap: () {}),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      StringConstants.popularHotelsTxt,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ((state is StateOnSuccess<GettingStartedData> &&
                            state.response.imageListValue != null)
                        ? (state.response.imageLoading == true)
                            ? const ImageSliderShimmer()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    state.response.imageListValue!.length,
                                    (index) {
                                  var imagelist =
                                      state.response.imageListValue?.toList();

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
                                                  imagelist[index].hotelName
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
                  ),
                  16.verticalSpace,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      StringConstants.popularTourTxt,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: ((state is StateOnSuccess<GettingStartedData> &&
                            state.response.toursListValue != null)
                        ? (state.response.tourLoading == true)
                            ? const ImageSliderShimmer()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    state.response.toursListValue!.length,
                                    (index) {
                                  var tourdata =
                                      state.response.toursListValue?[index];
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
                  ),
                  16.verticalSpace
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
