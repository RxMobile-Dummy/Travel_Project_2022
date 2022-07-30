import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../../utils/constants/string_constants.dart';

import 'icon_button.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomIconButton(
            backColor: const Color(0xff3b5998),
            icon: const Icon(Icons.facebook_rounded),
            text: StringConstants.facebookTxt,
            textColor: MakeMyTripColors.colorWhite,
            onTap: () {
              BlocProvider.of<UserCubit>(context).signInWithFacebook();
            },
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: CustomIconButton(
              backColor: MakeMyTripColors.colorWhite,
              textColor: MakeMyTripColors.colorBlack,
              icon: Image.asset(
                ImagePath.icGoogleLogo,
                width: 24,
              ),
              onTap: () {
                BlocProvider.of<UserCubit>(context).signInWithGoogle();
              },
              text: StringConstants.googleTxt),
        ),
      ],
    );
  }
}
