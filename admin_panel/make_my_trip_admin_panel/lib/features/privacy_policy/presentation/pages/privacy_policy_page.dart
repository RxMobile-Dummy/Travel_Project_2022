import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/privacy_policy/presentation/cubit/privacy_policy_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/html_editor/content_model.dart';
import '../../../../utils/html_editor/editor.dart';

class PrivacyPolicyPage extends StatelessWidget {
  PrivacyPolicyPage({Key? key}) : super(key: key);

  List<ContentModel> contentModel = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivacyPolicyCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          contentModel = state.response;
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        StringConstants.privacyPolicy,
                        style: AppTextStyles.labelNameTextStyle
                            .copyWith(color: MakeMyTripColors.customDarkBlue),
                      ),
                    ),
                  ),
                    const Divider(
                      color: MakeMyTripColors.colorBlack,
                    ),
                    EditorPage(
                      contentModel: contentModel,
                      callback: (String val) async {
                        await context
                            .read<PrivacyPolicyCubit>()
                            .updatePrivacyPolicyData(val);
                      },
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
