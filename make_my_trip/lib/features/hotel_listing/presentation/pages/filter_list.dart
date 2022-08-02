import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../utils/constants/string_constants.dart';

class FilterList extends StatefulWidget {
  FilterList({Key? key}) : super(key: key);

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  RangeValues _currentRangeValues = const RangeValues(5000, 8000);

  List amenitiesList = [
    "Parking",
    "Healthy Breakfast",
    "AC",
    "Wifi",
    "Transportation",
    "Laundry",
    "Entertainment"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          StringConstants.filters,
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Rating",
              style: AppTextStyles.labelDetails
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Wrap(
              children: List.generate(
                  5,
                  (index) => Container(
                        margin: const EdgeInsets.only(left: 12, bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MakeMyTripColors.color30gray),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: MakeMyTripColors.accentColor,
                            ),
                            4.horizontalSpace,
                            Text(
                              (index + 1).toString(),
                              style: AppTextStyles.labelDescriptionStyle
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Divider(
              color: MakeMyTripColors.color30gray,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Amenities",
              style: AppTextStyles.labelDetails
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Wrap(
              children: List.generate(
                  amenitiesList.length,
                  (index) => Container(
                        margin: const EdgeInsets.only(left: 12, bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MakeMyTripColors.color30gray),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text(
                          amenitiesList[index],
                          style: AppTextStyles.labelDescriptionStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 12),
            child: Divider(
              color: MakeMyTripColors.color30gray,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              "Price Range",
              style: AppTextStyles.labelDetails
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          RangeSlider(
            values: _currentRangeValues,
            max: 20000,
            min: 5000,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹${_currentRangeValues.start.floor()}.00",
                    style: AppTextStyles.labelDetails
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
                Text("₹${_currentRangeValues.end.floor()}.00",
                    style: AppTextStyles.labelDetails
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Divider(
                color: MakeMyTripColors.color30gray,
                thickness: 1,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    amenitiesList.length,
                    (index) => Container(
                          margin: const EdgeInsets.only(left: 12, bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: MakeMyTripColors.color30gray),
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            amenitiesList[index],
                            style: AppTextStyles.labelDescriptionStyle
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        )),
              ),
            ),
            FractionallySizedBox(
                widthFactor: .9,
                child: CommonPrimaryButton(
                    text: StringConstants.doneTxt, onTap: () {})),
          ],
        ),
      ),
    );
  }
}
