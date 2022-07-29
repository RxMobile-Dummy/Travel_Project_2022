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
              statusCode: "500");
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Explore",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            12.verticalSpace,
                            const Text(
                              "We hope you find what you \ncame for",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: MakeMyTripColors.color70gray),
                            ),
                          ],
                        ),
                        Image.asset(
                          ImagePath.introImage3,
                          width: MediaQuery.of(context).size.width * .35,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.search);
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                            hintText: "Search",
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
                        HomeFeatures(
                            iconData: Icons.hotel,
                            text: "Hotels",
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.search);
                            }),
                        HomeFeatures(
                            iconData: Icons.airplanemode_active_rounded,
                            text: "Flights",
                            onTap: () {}),
                        HomeFeatures(
                            iconData: Icons.maps_home_work,
                            text: "Places",
                            onTap: () {}),
                        HomeFeatures(
                            iconData: Icons.place,
                            text: "States",
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
                    child: ListTitleWidget(titleText: "Popular hotels"),
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
                                    child: PopularHotelWidget(
                                      rating:
                                          imagelist![index].rating.toString(),
                                      hotelName:
                                          imagelist[index].hotelName.toString(),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RoutesName.hotelDetail,
                                            arguments: {
                                              "hotel_id":
                                                  imagelist[index].hotelId
                                            });
                                      },
                                      imageData:
                                          imagelist[index].images![0].imageUrl!,
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
                    child: ListTitleWidget(titleText: "Popular tours"),
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
                                    child: PopularHotelWidget(
                                      rating: tourdata!.rating.toString(),
                                      hotelName: tourdata.tourName.toString(),
                                      onTap: () {},
                                      imageData: tourdata.images!.first.imageUrl
                                          .toString(),
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

class ListTitleWidget extends StatelessWidget {
  const ListTitleWidget({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleText,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class HomeFeatures extends StatelessWidget {
  const HomeFeatures({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
            color: MakeMyTripColors.accentColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 32,
            ),
            8.verticalSpace,
            Text(text),
          ],
        ),
      ),
    );
  }
}

class PopularHotelWidget extends StatelessWidget {
  const PopularHotelWidget({
    Key? key,
    required this.rating,
    this.address,
    required this.hotelName,
    required this.onTap,
    required this.imageData,
  }) : super(key: key);

  final VoidCallback onTap;
  final String rating, hotelName, imageData;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * .35,
                width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        opacity: .8,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.lighten),
                        fit: BoxFit.cover,
                        image: NetworkImage(imageData))),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rate_rounded,
                          size: 18, color: Colors.white),
                      Text(
                        rating,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          8.verticalSpace,
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              hotelName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          8.verticalSpace,
          (address == null || address!.isEmpty)
              ? const SizedBox()
              : SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: MakeMyTripColors.color30gray,
                      ),
                      4.horizontalSpace,
                      Expanded(
                        child: Text(
                          address!,
                          style: const TextStyle(
                            color: MakeMyTripColors.color70gray,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
