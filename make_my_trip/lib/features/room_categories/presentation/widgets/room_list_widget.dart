import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class RoomListWidget extends StatelessWidget {
  const RoomListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 24.0, right: 24.0, top: 16, bottom: 6.0),
          child: Text(
            StringConstants.roomCategory,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        6.verticalSpace,
        Row(
          children: [
            24.horizontalSpace,
            Expanded(
              child: Text(
                StringConstants.roomDescription,
                style: AppTextStyles.labelDescriptionStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Row(
          children: [
            8.horizontalSpace,
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  ImagePath.demoroom,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  ImagePath.demoroom,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            8.horizontalSpace,
          ],
        ),
        6.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.horizontalSpace,
            const Icon(
              Icons.star,
              size: 15,
            ),
            Expanded(
                flex: 5,
                child: Text(
                  StringConstants.roomFeature1,
                  style: AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
                )),
            const Spacer(),
            const Icon(
              Icons.star,
              size: 15,
            ),
            Expanded(
                flex: 5,
                child: Text(
                  StringConstants.roomFeature2,
                  style: AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
                )),
            4.horizontalSpace,
          ],
        ),
        6.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.horizontalSpace,
            const Icon(
              Icons.star,
              size: 15,
            ),
            Expanded(
                flex: 5,
                child: Text(
                  StringConstants.roomFeature3,
                  style: AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
                )),
            const Spacer(),
            const Icon(
              Icons.star,
              size: 15,
            ),
            Expanded(
                flex: 5,
                child: Text(
                  StringConstants.roomFeature4,
                  style: AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
                )),
            4.horizontalSpace,
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 6.0),
          child: GestureDetector(
            child: Text(
              StringConstants.roomMoreDetails,
              style: AppTextStyles.infoContentStyle2.copyWith(fontSize: 14),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                8.horizontalSpace,
                Text(
                  StringConstants.roomPrice,
                  style: AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ))),
                    child: Text(
                      StringConstants.roomSelectButtonTxt,
                      style:
                          AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                8.horizontalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
