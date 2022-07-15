import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class PublishReviewPage extends StatelessWidget {
  PublishReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _val = 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            StringConstants.writeAReview,
            style: AppTextStyles.unselectedLabelStyle,
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.close,
                color: MakeMyTripColors.accentColor, size: 25)),
        actions: [
          GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Center(
                  child: Text(
                    StringConstants.publish,
                    style: AppTextStyles.infoContentStyle2,
                  ),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  20.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: MakeMyTripColors.color50gray,
                      ),
                      10.horizontalSpace,
                      Text(StringConstants.review,
                          style: AppTextStyles.infoContentStyle)
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 39, right: 8),
                    child: TextFormField(
                      maxLength: 200,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            20.verticalSpace,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConstants.cleanliness,
                        style: AppTextStyles.labelDescriptionStyle,
                      ),
                      Text(
                        '1.0',
                        style: AppTextStyles.infoContentStyle,
                      ),
                    ],
                  ),
                ),
                Slider(
                    value: _val.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    divisions: 10,
                    thumbColor: Colors.white,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[400],
                    onChanged: (double? value) {}),
                15.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comfort',
                        style: AppTextStyles.labelDescriptionStyle,
                      ),
                      Text(
                        '1.0',
                        style: AppTextStyles.infoContentStyle,
                      )
                    ],
                  ),
                ),
                Slider(
                    value: _val.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    divisions: 10,
                    thumbColor: Colors.white,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[400],
                    onChanged: (double? value) {}),
                15.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Location',
                        style: AppTextStyles.labelDescriptionStyle,
                      ),
                      Text(
                        '1.0',
                        style: AppTextStyles.infoContentStyle,
                      )
                    ],
                  ),
                ),
                Slider(
                    value: _val.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    divisions: 10,
                    thumbColor: Colors.white,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey[400],
                    onChanged: (double? value) {}),
                15.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Facilities',
                        style: AppTextStyles.labelDescriptionStyle,
                      ),
                      Text(
                        '1.0',
                        style: AppTextStyles.infoContentStyle,
                      )
                    ],
                  ),
                ),
                Slider(
                    value: _val.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    divisions: 10,
                    thumbColor: MakeMyTripColors.colorWhite,
                    activeColor: MakeMyTripColors.accentColor,
                    inactiveColor: Colors.grey[400],
                    onChanged: (double? value) {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
