import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/data/model/get_reviews_model.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MakeMyTripColors.color30gray)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(44),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    placeholder: ImagePath.userProfileImage1,
                    image: image,
                    height: 44,
                    width: 44,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImagePath.placeHolderImage,
                        fit: BoxFit.fitWidth,
                      );
                    }),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:
                        AppTextStyles.infoContentStyle.copyWith(fontSize: 18),
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
              const Spacer(),
              Text(
                date,
                style: AppTextStyles.labelDetails.copyWith(fontSize: 14),
              ),
            ],
          ),
          8.verticalSpace,
          Text(
            description,
            textAlign: TextAlign.justify,
            style: AppTextStyles.labelDescriptionStyle
                .copyWith(fontWeight: FontWeight.w400),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          (uploadedImages.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: uploadedImgCount,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12),
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
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
                        );
                      }),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
