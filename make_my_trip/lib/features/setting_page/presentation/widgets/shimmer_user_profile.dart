import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileShimmer extends StatelessWidget {
  const UserProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          30.verticalSpace,
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.white,
              direction: ShimmerDirection.ltr,
              child: SafeArea(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: ListContainer(
                        width: size.width * 0.7,
                        hight: 20,
                      ),
                    ),
                    70.verticalSpace,
                    ListContainer(
                      width: size.width * 0.85,
                      hight: size.height * 0.05,
                    ),
                    45.verticalSpace,
                    ListContainer(
                      width: size.width * 0.85,
                      hight: size.height * 0.05,
                    ),
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
