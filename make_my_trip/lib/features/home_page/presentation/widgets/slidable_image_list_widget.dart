import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import '../../../../core/base/base_state.dart';
import '../manager/cubit/homepage_cubit.dart';

Widget slidableImageList() {
  return SizedBox(
    height: 200,
    width: double.infinity,
    child: BlocBuilder<HomepageCubit, BaseState>(builder: (context, state) {
      if (state is StateErrorGeneral) {
        return const Center(child: CircularProgressIndicator());
      } else {
        if ((state as StateOnSuccess<GettingStartedData>)
                .response
                .imageListValue !=
            null) {
          var imagelist = state.response.imageListValue?.toList();

          final List<Widget> imageSliders = imagelist!
              .map((item) => GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.hotelDetail,arguments: {"hotel_id" : item.hotelId});
            },
                child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item.imageUrl.toString(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                ),
                              ),
                            ],
                          )),
                    ),
              ))
              .toList();
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
          );
        } else {
          return Text(StringConstants.loading);
        }
      }
    }),
  );
}
