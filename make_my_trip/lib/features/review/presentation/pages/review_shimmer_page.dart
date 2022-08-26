import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/make_my_trip_colors.dart';


class ReviewPageShimmer extends StatelessWidget {
  const ReviewPageShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            70.verticalSpace,
            Expanded(
              child: Shimmer.fromColors(
                baseColor: MakeMyTripColors.color10gray,
                highlightColor: MakeMyTripColors.colorWhite,
                direction: ShimmerDirection.ltr,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20.0, left: 30, top: 20),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  color: MakeMyTripColors.accentColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ListContainer(width: size.width * 0.4 ,hight: 20,),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          ListContainer(width: size.width * 0.85,hight: 90,),
                          10.verticalSpace,
                          ListContainer(width: size.width * 0.4 ,hight: 20,),
                        ],
                      ),
                    ),
                  ),
                  itemCount: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
