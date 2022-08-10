import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotalDetails extends StatelessWidget {
  HotalDetails({Key? key, required this.wishlistModel}) : super(key: key);

  WishlistModel wishlistModel;

  @override
  Widget build(BuildContext context) {
    final _controller = PageController();
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, RoutesName.hotelDetail,
              arguments: {
                "hotel_id": wishlistModel.hotelId,
              });
          BlocProvider.of<WishListCubit>(context).getWish();
        },
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
                            itemCount: wishlistModel.wishListImage?.length,
                            pageSnapping: true,
                            itemBuilder: (context, index) {
                              return FadeInImage.assetNetwork(
                                  placeholder: ImagePath.placeHolderImage,
                                  image: wishlistModel
                                      .wishListImage![index].imageUrl
                                      .toString(),
                                  width: size.width * 10,
                                  fit: BoxFit.fill,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                        ImagePath.placeHolderImage,
                                        fit: BoxFit.fitWidth);
                                  });
                            })
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: wishlistModel.wishListImage?.length ?? 10,
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
                        Flexible(
                          child: Text(
                            wishlistModel.hotelName ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: MakeMyTripColors.colorBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 22),
                          ),
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
                            Flexible(
                              child: Text(
                                wishlistModel.address?.addressLine.toString() ??
                                    "",
                                maxLines: 2,
                                style: const TextStyle(
                                    color: MakeMyTripColors.colorBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              StringConstants.wishlistRsSymbol,
                              style: const TextStyle(fontSize: 18),
                            ),
                            2.horizontalSpace,
                            GestureDetector(
                                onTap: () {},
                                child: Text(wishlistModel.price.toString(),
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
      ),
    );
  }
}
