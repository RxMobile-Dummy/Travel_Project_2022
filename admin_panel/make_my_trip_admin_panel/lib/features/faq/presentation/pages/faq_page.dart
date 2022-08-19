import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/faq/presentation/cubit/faq_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/content_model.dart';
import 'package:make_my_trip_admin_panel/utils/html_editor/editor.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';

class FaqPage extends StatelessWidget {
  FaqPage({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  List<ContentModel> contentModel = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          contentModel = state.response;
          titleController.text =
              contentModel.isNotEmpty ? contentModel[0].title ?? "" : "";
          return Scaffold(
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
                            hintStyle: AppTextStyles.unselectedLabelStyle
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w300)),
                      ),
                    ),
                    EditorPage(
                      callback: (String val) async {
                        await context
                            .read<FaqCubit>()
                            .updateFaqData(titleController.text, val);
                      },
                      contentModel: contentModel,
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
