import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../hotel_detail/presentation/widgets/features_item_widget.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key, required this.arg}) : super(key: key);
  Map<String, dynamic> arg;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            height: 50,
            color: MakeMyTripColors.colorBlack,
            child: Center(
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "DONE",
                    style: AppTextStyles.infoContentStyle3,
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            leading: const Icon(Icons.arrow_back_ios),
            title: const Center(child: Text("Confirmation")),
            actions: [17.horizontalSpace],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                15.verticalSpace,
                Container(
                    height: 50,
                    color: MakeMyTripColors.color10gray,
                    child: Row(
                      children: [
                        15.horizontalSpace,
                        const Icon(
                          Icons.check_circle,
                          color: MakeMyTripColors.colorGreen,
                        ),
                        7.horizontalSpace,
                        const Text(
                          "Completed Booking",
                          style: AppTextStyles.infoContentStyle,
                        )
                      ],
                    )),
                30.verticalSpace,
                Container(
                  color: MakeMyTripColors.color10gray,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          "HOTEL NAME",
                          style: AppTextStyles.infoContentStyle,
                        ),
                        subtitle: RatingBarIndicator(
                          unratedColor: MakeMyTripColors.color0gray,
                          rating: 4,
                          itemSize: 18,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: MakeMyTripColors.customLightBlue,
                          ),
                        ),
                      ),
                      const Divider(
                        color: MakeMyTripColors.colorBlack,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Check in",
                                style: AppTextStyles.infoLabelStyle,
                              ),
                              Text("Date",
                                  style: AppTextStyles.unselectedLabelStyle)
                            ],
                          ),
                          Container(
                            height: 35,
                            width: 1,
                            color: MakeMyTripColors.colorBlack,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Check out",
                                style: AppTextStyles.infoLabelStyle,
                              ),
                              Text(
                                "Date",
                                style: AppTextStyles.unselectedLabelStyle,
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(color: MakeMyTripColors.colorBlack),
                    ],
                  ),
                ),
                14.verticalSpace,
                Container(
                  color: MakeMyTripColors.color10gray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text("Room Rate"), Text("Rate")],
                        ),
                        4.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text("DISCOUNT"), Text("Rate")],
                        ),
                        4.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text("GST"), Text("Rate")],
                        ),
                        const Text("_ _ _ _ _ _ _"),
                        7.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text("GRAND TOTAL"), Text("RATE")],
                        )
                      ],
                    ),
                  ),
                ),
                14.verticalSpace,
                Container(
                  color: MakeMyTripColors.color10gray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        2.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("ROOM TYPE"),
                              4.verticalSpace,
                              const Text("BED SIZE"),
                              4.verticalSpace,
                              const Text("TOTAL GUESTS")
                            ],
                          ),
                        ),
                        5.verticalSpace,
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Description",
                            textAlign: TextAlign.justify,
                            style: AppTextStyles.labelDescriptionStyle,
                          ),
                        ),
                        10.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MakeMyTripColors.customLightBlue),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: const [
                                  FeaturesItemWidget(text: "feature1"),
                                  FeaturesItemWidget(text: "feature2"),
                                  FeaturesItemWidget(text: "feature3"),
                                  FeaturesItemWidget(text: "feature3"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        2.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Free BreakFast"),
                              4.verticalSpace,
                              const Text("Pay Upon Arival"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
