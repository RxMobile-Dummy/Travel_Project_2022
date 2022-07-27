import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_state.dart';

import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/navigation/route_info.dart';
import '../../../../utils/constants/image_path.dart';
import '../widgets/intro_widget.dart';

class IntroPage extends StatelessWidget {
  IntroPage({Key? key}) : super(key: key);

  int introIndex = 0;

  PageController introSliderController = PageController();
  final List<Widget> _introPages = <Widget>[
    IntroWidget(
      imagepath: ImagePath.introImage1,
      title: StringConstants.introTitle1,
      subtitle: StringConstants.introSubtitle1,
    ),
    IntroWidget(
      imagepath: ImagePath.introImage2,
      title: StringConstants.introTitle2,
      subtitle: StringConstants.introSubtitle2,
    ),
    IntroWidget(
      imagepath: ImagePath.introImage3,
      title: StringConstants.introTitle3,
      subtitle: StringConstants.introSubtitle3,
    ),
    IntroWidget(
      imagepath: ImagePath.introImage4,
      title: StringConstants.introTitle4,
      subtitle: StringConstants.introSubtitle4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroCubit, IntroState>(
      listener: (context, state) {
        if (state is IntroSucessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: introSliderController,
                onPageChanged: (index) {
                  BlocProvider.of<IntroCubit>(context)
                      .nextIndicator(index.toDouble());
                },
                children: List.generate(_introPages.length, (index) {
                  return _introPages[index];
                }),
              ),
            ),
            BlocBuilder<IntroCubit, IntroState>(
              builder: (context, state) {
                (state is IndicatorIndexState)
                    ? introIndex = state.index.toInt()
                    : 0;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (introIndex != 3) {
                            introSliderController.jumpToPage(4);
                          }
                        },
                        child: Text(
                          StringConstants.skipTxt.toUpperCase(),
                          style: TextStyle(
                              color: (introIndex == 3)
                                  ? MakeMyTripColors.accentColor.withOpacity(0)
                                  : MakeMyTripColors.accentColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                    SmoothPageIndicator(
                      controller: introSliderController,
                      count: 4,
                      effect: CustomizableEffect(
                        activeDotDecoration: DotDecoration(
                          width: 24,
                          height: 10,
                          color: MakeMyTripColors.accentColor,
                          rotationAngle: 180,
                          verticalOffset: 0,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        dotDecoration: DotDecoration(
                          width: 24,
                          height: 10,
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16),
                          verticalOffset: 1,
                        ),
                        spacing: 6.0,
                        inActiveColorOverride: (i) =>
                            MakeMyTripColors.accentColor.withOpacity(.3),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (introIndex == 3) {
                            BlocProvider.of<IntroCubit>(context)
                                .anonymouslyLogIn();
                          } else {
                            introSliderController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        },
                        child: state is AuthLoading
                            ? const SizedBox(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                                height: 20.0,
                                width: 20.0,
                              )
                            : Text(
                                (introIndex == 3)
                                    ? StringConstants.doneTxt.toUpperCase()
                                    : StringConstants.nextTxt.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: MakeMyTripColors.accentColor,
                                    fontWeight: FontWeight.w500),
                              )),
                  ],
                );
              },
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
