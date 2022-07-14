import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../manager/cubit/homepage_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      AspectRatio(
        aspectRatio: 15 / 10,
        child: Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  ImagePath.darkbgimage,
                ),
              ),
            ),
            height: 350.0,
          ),
          Container(
            height: 350.0,
            decoration: BoxDecoration(
                color: MakeMyTripColors.colorBlack,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      MakeMyTripColors.colorBlack.withOpacity(0.0),
                      MakeMyTripColors.colorWhite,
                    ],
                    stops: const [
                      0.0,
                      1.0
                    ])),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(StringConstants.appname,
                          style: AppTextStyles.labelStyle2),
                      const Icon(
                        Icons.search,
                        color: MakeMyTripColors.colorWhite,
                        size: 25,
                      )
                    ],
                  ),
                ),
                //Divider(thickness: 1.8,),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MakeMyTripColors.colorWhite,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 80,
                          width: 350,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        10.horizontalSpace,
                        Column(
                          children: [
                            SizedBox(
                              height: 66,
                              width: 75,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: MakeMyTripColors.colorBlack,
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    )
                                  ],
                                ),
                                child: ClipOval(
                                  child: Material(
                                    color: MakeMyTripColors.color10gray,
                                    // button color
                                    child: InkWell(
                                      // splashColor: Colors.red, // inkwell color
                                      child: const SizedBox(
                                        width: 46,
                                        height: 46,
                                        child: Icon(
                                          Icons.business_sharp,
                                          color: MakeMyTripColors.colorRedDark,
                                          size: 35,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            4.verticalSpace,
                            Text(StringConstants.hotels,
                                style: AppTextStyles.infoContentStyle)
                          ],
                        ),
                        10.horizontalSpace,
                        Column(
                          children: [
                            SizedBox(
                              height: 66,
                              width: 75,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    )
                                  ],
                                ),
                                child: ClipOval(
                                  child: Material(
                                    color: MakeMyTripColors.color10gray,
                                    // button color
                                    child: InkWell(
                                      // splashColor: Colors.red, // inkwell color
                                      child: const SizedBox(
                                        width: 46,
                                        height: 46,
                                        child: Icon(
                                          Icons.place,
                                          color: MakeMyTripColors.accentColor,
                                          size: 35,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            4.verticalSpace,
                            Text(StringConstants.places,
                                style: AppTextStyles.infoContentStyle)
                          ],
                        ),
                        10.horizontalSpace,
                        Column(
                          children: [
                            SizedBox(
                              height: 66,
                              width: 75,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    )
                                  ],
                                ),
                                child: ClipOval(
                                  child: Material(
                                    color: MakeMyTripColors.color10gray,
                                    // button color
                                    child: InkWell(
                                      // splashColor: Colors.red, // inkwell color
                                      child: const SizedBox(
                                        width: 46,
                                        height: 46,
                                        child: Icon(
                                          Icons.maps_home_work,
                                          color: MakeMyTripColors.colorGreen,
                                          size: 35,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            4.verticalSpace,
                            Text(StringConstants.states,
                                style: AppTextStyles.infoContentStyle)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                27.verticalSpace
              ],
            ),
          )
        ]),
      ),
      15.verticalSpace,
      Container(
        height: 200,
        width: double.infinity,
        child: BlocBuilder<HomepageCubit, StateOnSuccess<GettingStartedData>>(
            builder: (context, state) {
          if (state.response.imageListValue != null) {
            var imagelist = state.response.imageListValue?.toList();

            final List<Widget> imageSliders = imagelist!
                .map((item) => Container(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                Image.network(item.imageUrl.toString(),
                                    fit: BoxFit.cover, width: 1000.0),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ))
                .toList();
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                autoPlayInterval: const Duration(seconds: 7),
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            );
          } else {
            return Text("Loading");
          }
        }),
      ),
      27.verticalSpace,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(StringConstants.populartours,
                style: AppTextStyles.infoContentStyle2),
            Text(
              StringConstants.viewall,
              style: AppTextStyles.infoContentStyle2,
            )
          ],
        ),
      ),
      BlocBuilder<HomepageCubit, StateOnSuccess<GettingStartedData>>(
        builder: (BuildContext context, state) {
          if (state.response.toursListValue == null) {
            return Text("Loading...!");
          } else {
            return Container(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.response.toursListValue?.length,
                itemBuilder: (BuildContext context, int index) {
                  var hoteldata = state.response.toursListValue?[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopularTours(
                        hoteldata!.details!.first.imageUrl.toString(),
                        hoteldata.tourName.toString(),
                        hoteldata.price.toString(),
                        hoteldata.rating!.toInt()),
                  );
                },
              ),
            );
          }
        },
      )
    ]));
  }
}

Widget PopularTours(
    String image, String tourname, String price, int total_ratings) {
  return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
          color: MakeMyTripColors.colorBlack,
          borderRadius: BorderRadius.circular(10),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              8.horizontalSpace,
              Text(
                tourname,
                style: AppTextStyles.infoContentStyle3,
              ),
            ],
          ),
          5.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Ratings(total_ratings),
                Text(
                  "₹ ${price}",
                  style: AppTextStyles.infoContentStyle2,
                ),
              ],
            ),
          ),
          6.verticalSpace
        ],
      ));
}

Widget Ratings(int Rating) {
  if (Rating == 4) {
    return Row(
      children: const [
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20)
      ],
    );
  }
  if (Rating == 5) {
    return Row(
      children: const [
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20)
      ],
    );
  }
  if (Rating == 3) {
    return Row(
      children: const [
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20)
      ],
    );
  }
  if (Rating == 2) {
    return Row(
      children: const [
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20)
      ],
    );
  }
  if (Rating == 1) {
    return Row(
      children: const [
        Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20)
      ],
    );
  } else {
    return Row(
      children: const [
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20),
        Icon(Icons.star, color: MakeMyTripColors.color50gray, size: 20)
      ],
    );
  }
}
