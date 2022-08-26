import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

class ConfirmationPageShimmer extends StatelessWidget {
  const ConfirmationPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Shimmer.fromColors(
            baseColor: MakeMyTripColors.color10gray,
            highlightColor: MakeMyTripColors.colorWhite,
            direction: ShimmerDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20.0, left: 23, top: 100, right: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListContainer(
                    hight: size.height * 0.04,
                    width: size.width * 0.5,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListContainer(
                        width: size.width * 0.9,
                        hight: size.height * 0.06,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListContainer(
                            width: size.width * 0.3,
                            hight: size.height * 0.03,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListContainer(
                            width: size.width * 0.3,
                            hight: size.height * 0.1,
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: ListContainer(
                            width: size.width * 0.3,
                            hight: size.height * 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  80.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListContainer(
                      hight: size.height * 0.04,
                      width: size.width * 0.6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListContainer(
                      hight: size.height * 0.04,
                      width: size.width * 0.4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListContainer(
                      hight: size.height * 0.05,
                      width: size.width * 0.9,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListContainer(
                      hight: size.height * 0.05,
                      width: size.width * 0.9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
