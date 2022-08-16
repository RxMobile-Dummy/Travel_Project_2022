import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_primary_button.dart';

class ReviewModeration extends StatelessWidget {
  const ReviewModeration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: MakeMyTripColors.accentColor.withOpacity(.2),
              )),
          Expanded(
            flex: 8,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Wrap(
                      runAlignment: WrapAlignment.start,
                      spacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        ReviewContainer(screen: screen),
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    Key? key,
    required this.screen,
  }) : super(key: key);

  final Size screen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen.width / 2 - (screen.width * .115),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: MakeMyTripColors.color10gray),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Image.asset(
                        ImagePath.userDefaultImg,
                        width: 32,
                      ),
                      12.horizontalSpace,
                      Text(
                        "Lorem Ipsum",
                        style: AppTextStyles.infoContentStyle4
                            .copyWith(color: MakeMyTripColors.colorBlack),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonPrimaryButton(
                          text: "Approve",
                          onTap: () {},
                          backColor: Colors.green,
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: CommonPrimaryButton(
                          text: "Reject",
                          onTap: () {},
                          backColor: MakeMyTripColors.colorRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, Lorem Ipsum is simply dcenturies, ",
                  style: AppTextStyles.labelDescriptionStyle.copyWith(
                      fontSize: 14, color: MakeMyTripColors.colorBlack),
                ),
                12.verticalSpace,
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                      4,
                      (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              ImagePath.roomImg,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
