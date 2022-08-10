import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/container_widget.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:shimmer/shimmer.dart';

class HotelDetailsShimmer extends StatelessWidget {
  const HotelDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SafeArea(
              child: Center(
                  child: ContainerWidget(
                      width: size.width, hight: size.height * 0.3)),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: MakeMyTripColors.color30gray,
                highlightColor: MakeMyTripColors.colorWhite,
                direction: ShimmerDirection.ltr,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // hotel name
                        ListContainer(
                          hight: 50,
                          width: size.width * 0.55,
                        ),

                        // hotel Rs. text
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ListContainer(
                              width: size.width * 0.35,
                              hight: 20,
                            )),

                        // hotel details text
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ListContainer(
                              width: size.width * 0.9,
                              hight: size.height * 0.09,
                            )),

                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListContainer(
                                    width: size.width * 0.3,
                                    hight: 20,
                                  )),
                              const Spacer(),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 23),
                                  child: ListContainer(
                                    width: size.width * 0.3,
                                    hight: 20,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListContainer(
                                    width: size.width * 0.3,
                                    hight: 20,
                                  )),
                              const Spacer(),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 23),
                                  child: ListContainer(
                                    width: size.width * 0.3,
                                    hight: 20,
                                  )),
                            ],
                          ),
                        ),

                        // hotel rating text
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ListContainer(
                              width: size.width * 0.9,
                              hight: 45,
                            )),

                        // hotel gallery text
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ListContainer(
                              width: size.width * 0.9,
                              hight: 45,
                            )),

                        // hotel location text
                        Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: ListContainer(
                              width: size.width * 0.35,
                              hight: 35,
                            )),
                        // hotel address text
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ListContainer(
                              width: size.width * 0.9,
                              hight: 45,
                            )),

                        // hotel location image
                        Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: ListContainer(
                              width: size.width * 0.9,
                              hight: size.height * 0.25,
                            )),
                      ],
                    ),
                  ),
                  itemCount: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
