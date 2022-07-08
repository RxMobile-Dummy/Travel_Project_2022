import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_state.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: BlocBuilder<IntroCubit, IntroState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AbsorbPointer(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                      (state is IndicatorIndexState && state.index == 3)
                          ? ""
                          : "Skip",
                      style: const TextStyle(
                          fontSize: 16, color: MakeMyTripColors.accentColor)),
                ),
              ),
              DotsIndicator(
                dotsCount: 4,
                position: (state is IndicatorIndexState) ? state.index : 0,
                decorator: DotsDecorator(
                  activeSize: const Size(24.0, 9.0),
                  activeColor: MakeMyTripColors.accentColor,
                  color: MakeMyTripColors.colorBlack,
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                    (state is IndicatorIndexState && state.index == 3)
                        ? "Done"
                        : "Next",
                    style: const TextStyle(
                        fontSize: 16, color: MakeMyTripColors.accentColor)),
              ),
            ],
          );
        },
      ),
    );
  }
}
