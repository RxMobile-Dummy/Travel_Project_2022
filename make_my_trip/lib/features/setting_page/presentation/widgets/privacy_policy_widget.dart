import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:make_my_trip/utils/widgets/loading_widget.dart';

import '../../../../core/base/base_state.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../data/models/content_model.dart';
import '../cubit/information_page_cubit.dart';
import '../cubit/setting_page_cubit.dart';

class PrivacyPolicyPage extends StatelessWidget {
  PrivacyPolicyPage({Key? key}) : super(key: key);

  List<ContentModel> contentModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.privacyPolicy),
      ),
      body: BlocBuilder<InformationPageCubit, BaseState>(
        builder: (context, state) {
          if (state is StateOnSuccess) {
            contentModel = state.response;
            return ListView.builder(
                itemCount: contentModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(
                      data: contentModel[index].title ?? "",
                    ),
                  );
                });
          } else {
            return const Center(child: LoadingWidget());
          }
        },
      ),
    );
  }
}