import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/data/models/faq_model.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';

class FaqPage extends StatelessWidget {
  FaqPage({Key? key}) : super(key: key);

  List<FaqModel> faqModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: BlocBuilder<SettingPageCubit, BaseState>(
        builder: (context, state) {
          if (state is StateOnSuccess) {
            faqModel = state.response;
          }
          return ListView.builder(
              itemCount: faqModel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: ExpansionTile(
                    title: Text(
                      faqModel[index].title ?? "",
                      style: AppTextStyles.mediumLabelStyle,
                    ),
                    children: [
                      ListTile(
                        title: Text(faqModel[index].subtitle ?? ""),
                      )
                    ],
                  )),
                );
              });
        },
      ),
    );
  }
}
