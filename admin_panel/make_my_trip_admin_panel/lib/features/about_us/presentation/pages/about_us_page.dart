import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/about_us/presentation/cubit/about_us_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/html_editor/content_model.dart';
import '../../../../utils/html_editor/editor.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({Key? key}) : super(key: key);

  List<ContentModel> contentModel = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutUsCubit, BaseState>(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 36.0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          StringConstants.aboutUs,
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
                      callback: (val) async {
                        await context
                            .read<AboutUsCubit>()
                            .updateAboutUsData(val);
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
