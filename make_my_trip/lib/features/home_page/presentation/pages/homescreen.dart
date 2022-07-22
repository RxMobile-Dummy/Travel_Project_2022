import 'package:flutter/material.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/slidable_image_list_widget.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/title_widget.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/top_view_widget.dart';
import 'package:make_my_trip/features/home_page/presentation/widgets/tour_list_widget.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              topView(context),
              15.verticalSpace,
              slidableImageList(),
              17.verticalSpace,
              titleWidget(),
              popularTourList(),
            ],
          ),
        ),
      )),
    );
  }
}
