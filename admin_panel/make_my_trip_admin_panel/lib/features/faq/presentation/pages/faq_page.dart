import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/editor.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';

class FaqPage extends StatefulWidget {
  FaqPage({Key? key}) : super(key: key);

  @override
  _HtmlEditorExampleState createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends State<FaqPage> {
  //String result = '';
  final HtmlEditorController controller = HtmlEditorController();
  final TextEditingController titleController = TextEditingController();

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
                  StringConstants.faq,
                  style: AppTextStyles.labelStyle
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: StringConstants.faqHint,
                        hintStyle: AppTextStyles.unselectedLabelStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w300)),
                  ),
                ),
                EditorPage(
                  // controller: controller,
                  // onTap: () {
                  //   controller.getText().then((value) =>
                  //       FirebaseFirestore.instance.collection('faq').add({
                  //         'title': titleController.text,
                  //         'subtitle': value,
                  //       }));
                  // },
                  contentModel: [],
                  callback: (String val) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
