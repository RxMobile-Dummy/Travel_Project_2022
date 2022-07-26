
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: SafeArea(
          child: CarouselSlider.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int itemIndex,
                int pageViewIndex) =>
                ListContainer(
                    width: size.width * 0.7, hight: size.height * 0.7),
            options: CarouselOptions(
              enlargeCenterPage: true,
              disableCenter: true,
              autoPlay: true,
              viewportFraction: 0.7,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          ),
        ),
      ),
    );

  }
}
