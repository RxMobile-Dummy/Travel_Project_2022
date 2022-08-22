import 'package:flutter/material.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../../../../core/theme/text_styles.dart';
import '../widgets/textfield_widget.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({Key? key}) : super(key: key);

  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              StringConstants.contactUs,
              style: AppTextStyles.labelStyle
                  .copyWith(fontWeight: FontWeight.w300),
            ),
          ),
          ContactUsBody(
            controller: emailController,
            hinttxt: StringConstants.emailHint,
            title: StringConstants.email,
          ),
          ContactUsBody(
            controller: numberController,
            hinttxt: StringConstants.numberHint,
            title: StringConstants.number,
          )
        ],
      ),
    );
  }
}
