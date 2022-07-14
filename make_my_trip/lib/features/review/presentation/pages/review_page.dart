import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/review/presentation/pages/publish_review_page.dart';
import 'package:make_my_trip/features/review/presentation/widgets/review_card_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: MakeMyTripColors.accentColor,
              size: 18,
            ),
            label: Text(
              StringConstants.back,
              style: const TextStyle(
                  fontSize: 18, color: MakeMyTripColors.accentColor),
            )),
        title: Text(
          StringConstants.reviews,
          style: AppTextStyles.unselectedLabelStyle,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.more_horiz,
                color: MakeMyTripColors.accentColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(
                          color: MakeMyTripColors.color50gray)),
                  child: SizedBox(
                    height: 18,
                    width: 40,
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: MakeMyTripColors.accentColor,
                        ),
                        Text(StringConstants.fourPointNine),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                StringConstants.thirtyFourReviews,
                style: const TextStyle(color: MakeMyTripColors.color50gray),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ReviewCardWidget(
                    date: StringConstants.reviewCardDate,
                    name: StringConstants.reviewCardName,
                    description: StringConstants.reviewCardDesc,
                    ratingValue: 4.0,
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PublishReviewPage()));
          },
          backgroundColor: MakeMyTripColors.accentColor,
          child: const Icon(Icons.add)),
    ));
  }
}
