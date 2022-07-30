import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';

class HomeListWidget extends StatelessWidget {
  const HomeListWidget({
    Key? key,
    required this.rating,
    this.address,
    required this.hotelName,
    required this.onTap,
    required this.imageData,
  }) : super(key: key);

  final VoidCallback onTap;
  final String rating, hotelName, imageData;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * .35,
                width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        opacity: .8,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.lighten),
                        fit: BoxFit.cover,
                        image: NetworkImage(imageData))),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rate_rounded,
                          size: 18, color: Colors.white),
                      Text(
                        rating,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          8.verticalSpace,
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              hotelName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          8.verticalSpace,
          (address == null || address!.isEmpty)
              ? const SizedBox()
              : SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: MakeMyTripColors.color30gray,
                      ),
                      4.horizontalSpace,
                      Expanded(
                        child: Text(
                          address!,
                          style: const TextStyle(
                            color: MakeMyTripColors.color70gray,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
