import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_state.dart';

class Indicator extends StatelessWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: BlocBuilder<IntroCubit, IntroState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: 4,
                position: (state is IndicatorIndexState) ? state.index : 0,
                decorator: DotsDecorator(
                  activeSize: const Size(24.0, 9.0),
                  activeColor: Colors.blue,
                  color: Colors.black,
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
