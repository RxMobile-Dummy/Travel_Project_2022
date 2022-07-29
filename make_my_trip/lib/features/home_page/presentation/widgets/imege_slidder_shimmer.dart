import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/list_container_widget.dart';
import 'package:shimmer/shimmer.dart';

class ImageSliderShimmer extends StatelessWidget {
  const ImageSliderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        direction: ShimmerDirection.ltr,
        child: Row(
          children: List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ListContainer(
                  width: size.width * 0.6, hight: size.height * 0.2),
            ),
          ),
        ));
  }
}
