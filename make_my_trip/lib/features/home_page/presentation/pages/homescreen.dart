import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
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
    return SingleChildScrollView(
      child: Column(children: [
        AspectRatio(
          aspectRatio: 15 / 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
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
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, bottom: 5.0),
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
                                          height: 100,
                                          child: Icon(
                                            Icons.business_sharp,
                                            color:
                                                MakeMyTripColors.colorRedDark,
                                            size: 35,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              RoutesName.search,
                                              (route) => true);
                                        },
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
          child:
              BlocBuilder<HomepageCubit, BaseState>(builder: (context, state) {
            if (state is StateErrorGeneral) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if ((state as StateOnSuccess<GettingStartedData>)
                      .response
                      .imageListValue !=
                  null) {
                var imagelist = state.response.imageListValue?.toList();

                final List<Widget> imageSliders = imagelist!
                    .map((item) => Container(
                          margin: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    item.imageUrl.toString(),
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                  ),
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
                StringConstants.viewallTxt,
                style: AppTextStyles.infoContentStyle2,
              )
            ],
          ),
        ),
        BlocBuilder<HomepageCubit, BaseState>(
          builder: (BuildContext context, state) {
            if (state is StateErrorGeneral) {
              return const CircularProgressIndicator();
            } else {
              if ((state as StateOnSuccess<GettingStartedData>)
                      .response
                      .toursListValue ==
                  null) {
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
                            hoteldata!.images!.first.imageUrl.toString(),
                            hoteldata.tourName.toString(),
                            hoteldata.price.toString(),
                            hoteldata.rating!.toInt()),
                      );
                    },
                  ),
                );
              }
            }
          },
        )
      ]),
    );
  }
}

Widget PopularTours(
    String image, String tourname, String price, int total_ratings) {
  return Container(
      padding: const EdgeInsets.only(right: 80, left: 8),
      decoration: BoxDecoration(
          color: MakeMyTripColors.colorBlack,
          borderRadius: BorderRadius.circular(10),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              tourname,
              style: AppTextStyles.infoContentStyle3,
            ),
          ),
          5.verticalSpace,
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            itemSize: 18,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
          6.verticalSpace
        ],
      ));
}
