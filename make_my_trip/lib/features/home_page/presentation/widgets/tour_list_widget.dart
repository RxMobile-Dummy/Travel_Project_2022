import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import '../cubit/homepage_cubit.dart';

Widget popularTourList() {
  return BlocBuilder<HomepageCubit, BaseState>(
      builder: (BuildContext context, state) {
    if (state is StateErrorGeneral) {
      return const CircularProgressIndicator();
    } else {
      if ((state as StateOnSuccess<GettingStartedData>)
              .response
              .toursListValue ==
          null) {
        return Text(StringConstants.loading);
      } else {
        return SizedBox(
            height: 220,
            child: ListView.builder(
                itemCount: state.response.toursListValue?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  var tourdata = state.response.toursListValue?[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 400,
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: MakeMyTripColors.colorBlack,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(tourdata!
                                            .images!.first.imageUrl
                                            .toString()),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                    color: MakeMyTripColors.customDarkBlue,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 0, 7),
                                      child: Text(tourdata.tourName.toString(),
                                          style:
                                              AppTextStyles.infoContentStyle5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0, 10, 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RatingBarIndicator(
                                            unratedColor:
                                                MakeMyTripColors.color0gray,
                                            rating: tourdata.rating!.toDouble(),
                                            itemSize: 18,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: MakeMyTripColors
                                                  .customLightBlue,
                                            ),
                                          ),
                                          Text(
                                              StringConstants.wishlistRsSymbol +
                                                  " " +
                                                  tourdata.price.toString(),
                                              style: AppTextStyles
                                                  .infoContentStyle5),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ));
                }));
      }
    }
  });
}
