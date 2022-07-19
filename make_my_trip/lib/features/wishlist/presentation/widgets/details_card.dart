import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Hotal_Details extends StatelessWidget {
  const Hotal_Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = PageController();
    final size = MediaQuery.of(context).size;

    List<String> images = [
          ImagePath.wishlistImage2,
          ImagePath.wishlistImage1,
          ImagePath.wishlistImage2,
          ImagePath.wishlistImage1
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: SizedBox(
          height: 250,
          width: size.width * 10,
          child: Column(
            children: [
              Expanded(
                flex: 60,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView(children: [
                      PageView.builder(
                          controller: _controller,
                          itemCount: images.length,
                          pageSnapping: true,
                          itemBuilder: (context, pagePosition) {
                            return Image.asset(
                              images[pagePosition],
                              width: size.width * 10,
                              height: 150,
                              fit: BoxFit.fill,
                            );
                          })
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: images.length,
                        axisDirection: Axis.horizontal,
                        effect: const SlideEffect(
                          activeDotColor: Colors.white,
                          dotHeight: 10,
                          dotColor: MakeMyTripColors.color50gray,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      6.verticalSpace,
                      Text(
                        StringConstants.wishlistTitle,
                        style: const TextStyle(
                            color: MakeMyTripColors.colorBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 15,
                          ),
                          2.horizontalSpace,
                          Text(
                            StringConstants.wishlistLocationName,
                            style: const TextStyle(
                                color: MakeMyTripColors.colorBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          const Spacer(),
                          Text(
                            StringConstants.wishlistRsSymbol,
                            style: const TextStyle(fontSize: 18),
                          ),
                          2.horizontalSpace,
                          GestureDetector(
                              onTap: () {},
                              child: Text(StringConstants.wishlistRs,
                                  style: const TextStyle(
                                      color: MakeMyTripColors.colorBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                          25.horizontalSpace
                        ],
                      ),
                      6.verticalSpace,
                      Row(
                        children: [
                          const Icon(Icons.check,
                              color: Colors.green, size: 18),
                          Text(
                            StringConstants.wishlistSublineText,
                            style: TextStyle(
                                color: Colors.green[300], fontSize: 11),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
