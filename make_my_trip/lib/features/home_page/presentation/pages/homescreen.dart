import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> imgList = [
    ImagePath.imagecenter,
    ImagePath.imagecenter2,
    ImagePath.imagecenter3,
  ];
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return SafeArea(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 15 / 10,
            child: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
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
                        stops: [
                          0.0,
                          1.0
                        ])),
                child: Column(
                  children: [
                    SizedBox(
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
                          Icon(
                            Icons.search,
                            color: MakeMyTripColors.colorWhite,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                    //Divider(thickness: 1.8,),
                    SizedBox(
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
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 66,
                                  width: 75,
                                  child: ClipOval(
                                    child: Image.asset(ImagePath.hotelimage,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(StringConstants.hotels,
                                    style: AppTextStyles.infoContentStyle)
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 66,
                                  width: 75,
                                  child: ClipOval(
                                    child: Image.asset(
                                      ImagePath.placesimage,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(StringConstants.places,
                                    style: AppTextStyles.infoContentStyle)
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 66,
                                  width: 75,
                                  child: ClipOval(
                                    child: Image.asset(ImagePath.statesimage,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(StringConstants.states,
                                    style: AppTextStyles.infoContentStyle)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 27,
                    ),
                  ],
                ),
              )
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                autoPlayInterval: const Duration(seconds: 7),
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
          ),
          SizedBox(
            height: 27,
          ),
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
          Container(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopularTours(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget PopularTours() {
  return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
          color: MakeMyTripColors.colorBlack,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(ImagePath.demoroom), fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                "Las Vegas",
                style: AppTextStyles.infoContentStyle3,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Ratings(),
                Text(
                  "\$ 4500",
                  style: AppTextStyles.infoContentStyle3,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          )
        ],
      ));
}

Widget Ratings() {
  return Row(
    children: [
      Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
      Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
      Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
      Icon(Icons.star, color: MakeMyTripColors.colorWhite, size: 20),
      Icon(Icons.star, color: MakeMyTripColors.color90gray, size: 20)
    ],
  );
}
