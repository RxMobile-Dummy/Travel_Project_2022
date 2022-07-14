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

  const ReviewCardWidget(
      {Key? key,
      required this.name,
      required this.description,
      required this.date,
      required this.ratingValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: MakeMyTripColors.color10gray,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey)),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 14,
                        backgroundColor: MakeMyTripColors.color30gray,
                        child: Icon(Icons.person)),
                    14.horizontalSpace,
                    Text(
                      '${name}',
                      style: AppTextStyles.infoContentStyle,
                    ),
                    70.horizontalSpace,
                    RatingBar.builder(
                      ignoreGestures: true,
                      itemSize: 16,
                      initialRating: ratingValue,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: MakeMyTripColors.accentColor,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 12.0),
                  child: Text(
                    '${description}',
                    style: AppTextStyles.labelDescriptionStyle,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    child: Text(
                      '${date}',
                      style: AppTextStyles.labelDetails,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
