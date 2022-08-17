import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/html_editor/editor.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _HtmlEditorExampleState createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends State<PrivacyPolicyPage> {
  //String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  StringConstants.privacyPolicy,
                  style: AppTextStyles.labelStyle
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                const Divider(
                  color: MakeMyTripColors.colorBlack,
                ),
                EditorPage(
                    controller: controller,
                    onTap: () async {
                      await controller.getText().then((value) =>
                          FirebaseFirestore.instance
                              .collection('privacyPolicy')
                              .add({
                            'title': value,
                          }));
                      controller.clear();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
