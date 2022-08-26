import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/presentation/cubit/publish_review_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';

class ReviewCardWidget extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final double ratingValue;
  final String image;
  final List<Images> uploadedImages;
  final int uploadedImgCount;
  const ReviewCardWidget(
      {Key? key,
      required this.name,
      required this.description,
      required this.date,
      required this.ratingValue,
      required this.image,
      required this.uploadedImages,
      required this.uploadedImgCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: MakeMyTripColors.colorWhite,
      //elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: MakeMyTripColors.color50gray)),
      child: SizedBox(
        //height: 120,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
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
                      radius: 25,
                      backgroundColor: MakeMyTripColors.color50gray,
                      child: CircleAvatar(
                        radius: 25,
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
                    flex: 4,
                    child: Text(
                      date,
                      style: AppTextStyles.labelDetails.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: AppTextStyles.labelDescriptionStyle
                      .copyWith(fontWeight: FontWeight.w400),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: uploadedImgCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(children: [
                        ClipRect(
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholder: ImagePath.placeHolderImage,
                              image: uploadedImages[index].imageUrl.toString(),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImagePath.placeHolderImage,
                                  fit: BoxFit.fitWidth,
                                );
                              }),
                        ),
                      ]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
