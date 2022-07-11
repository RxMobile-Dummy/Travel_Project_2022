import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';

import 'package:make_my_trip/utils/constants/string_constants.dart';
import '../../../../utils/constants/image_path.dart';
import '../widgets/indicator_widget.dart';
import '../widgets/intro_widget.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  PageController controller = PageController();
  final List<Widget> _list = <Widget>[
    Intro(
      imagepath: ImagePath.intro1,
      title: StringConstants.intro2Title,
      subtitle: StringConstants.intro1Subtitle,
    ),
    Intro(
      imagepath: ImagePath.intro2,
      title: StringConstants.intro2Title,
      subtitle: StringConstants.intro2Subtitle,
    ),
    Intro(
      imagepath: ImagePath.intro3,
      title: StringConstants.intro3Title,
      subtitle: StringConstants.intro3Subtitle,
    ),
    Intro(
      imagepath: ImagePath.intro4,
      title: StringConstants.intro4Title,
      subtitle: StringConstants.intro4Subtitle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: controller,
                onPageChanged: (num) {
                  BlocProvider.of<IntroCubit>(context)
                      .nextIndicator(num.toDouble());
                },
                children: List.generate(_list.length, (index) {
                  return _list[index];
                }),
              ),
            ),
            const Indicator(),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
