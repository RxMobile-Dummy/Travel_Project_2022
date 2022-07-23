import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class ReviewCardWidget extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final double ratingValue;
  final String image;

  const ReviewCardWidget(
      {Key? key,
      required this.name,
      required this.description,
      required this.date,
      required this.ratingValue,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Card(
        color: MakeMyTripColors.color10gray,
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: MakeMyTripColors.color50gray)),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: MakeMyTripColors.color50gray,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(image),
                        backgroundColor: MakeMyTripColors.color30gray,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.infoContentStyle
                              .copyWith(fontSize: 18),
                        ),
                        2.verticalSpace,
                        RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: 16,
                          initialRating: ratingValue,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: MakeMyTripColors.accentColor,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 5,
                    child: Text(
                      date,
                      style: AppTextStyles.labelDetails.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: AppTextStyles.labelDescriptionStyle
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
