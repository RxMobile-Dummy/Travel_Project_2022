import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: Text(
          "Confirmation",
          style: AppTextStyles.labelStyle.copyWith(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Booking Details",
                style: AppTextStyles.unselectedLabelStyle,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: MakeMyTripColors.color0gray,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HOTEL NAME",
                        style: AppTextStyles.infoContentStyle
                            .copyWith(fontSize: 18),
                      ),
                      RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 15,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.3),
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: MakeMyTripColors.accentColor,
                                size: 10,
                              ),
                          onRatingUpdate: (rating) {}),
                      4.verticalSpace,
                      const Text(
                        "Sanand Cir, Sarkhej, Ahmedabad, Gujarat, India 382210",
                        style: AppTextStyles.labelDetails,
                      ),
                      4.verticalSpace,
                      const Divider(
                        color: MakeMyTripColors.color70gray,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Room Type",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "Delux",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                      const Divider(
                        color: MakeMyTripColors.color70gray,
                      ),
                      12.verticalSpace,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            16.verticalSpace,
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Payment Summary",
                style: AppTextStyles.unselectedLabelStyle,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: MakeMyTripColors.color0gray,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Room Rate",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "5000",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                      4.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Total Room",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "2",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                      4.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Sub Total",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "10000",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                      4.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "GST (18%)",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "1800",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                      4.verticalSpace,
                      const Divider(
                        color: MakeMyTripColors.color70gray,
                      ),
                      4.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Offer",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "-1800",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                      4.verticalSpace,
                      const Divider(
                        color: MakeMyTripColors.color70gray,
                      ),
                      4.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Grant Total",
                            style: AppTextStyles.infoContentStyle,
                          ),
                          Text(
                            "10000",
                            style: AppTextStyles.labelDetails,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CommonPrimaryButton(
          onTap: () {},
          text: 'Book Now',
        ),
      ),
    );
  }
}
