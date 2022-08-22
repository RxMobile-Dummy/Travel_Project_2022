import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/constants/string_constants.dart';

class SettingProfileShimmer extends StatelessWidget {
  const SettingProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white,
              direction: ShimmerDirection.ltr,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: MakeMyTripColors.colorLightGray,
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 0.0),
                            child: ListContainer(
                              width: size.width * 0.5,
                              hight: 25,
                            )),
                        5.verticalSpace,
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 0.0),
                            child: ListContainer(
                              width: size.width * 0.3,
                              hight: 25,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
