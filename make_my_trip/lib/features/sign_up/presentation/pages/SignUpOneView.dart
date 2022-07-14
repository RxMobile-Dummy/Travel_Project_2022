import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/continue_button.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/termsAndPrivacy.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/text_field.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../hotel_listing/presentation/pages/home_page.dart';

class SignUpOneView extends StatelessWidget {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController conPass = TextEditingController();
  bool showProgress = false;

  SignUpOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: SingleChildScrollView(
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context,state){
            if(state is RegisterSuccess){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage()));
            }
          },
            builder: (context, state) {
      if (state is WaitingDialog) {
        return AlertDialog(
          title: Text("We have send you mail, Please confirm"),
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Text(
                StringConstants.SignUp,
                style: TextStyle(
                    color: MakeMyTripColors.color50gray,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFieldView(
                hintTextvar: StringConstants.fullname,
                textFieldViewController: fullname,
                obscuretext: false,
                id: 1),
            TextFieldView(
              hintTextvar: StringConstants.email,
              textFieldViewController: email,
              obscuretext: false,
              id: 2,
            ),
            TextFieldView(
              hintTextvar: StringConstants.password,
              textFieldViewController: pass,
              obscuretext: true,
              id: 3,
            ),
            TextFieldView(
              hintTextvar: StringConstants.conpassowrd,
              textFieldViewController: conPass,
              obscuretext: true,
              id: 4,
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                if (state is SignUpError) {
                  if (state.error.toString() == "") {
                    return SizedBox();
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(state.error,
                            style: TextStyle(color: MakeMyTripColors.colorRed)),
                        28.horizontalSpace
                      ],
                    );
                  }
                } else {
                  return Container();
                }
              }

            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ContinueButton(onTap: () {
                BlocProvider.of<SignUpCubit>(context)
                    .waiting_dialog(showProgress);
                BlocProvider.of<SignUpCubit>(context).create_User(
                    email: email.text,
                    password: pass.text,
                    confirmpassword: conPass.text,
                    fullname: fullname.text);
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
              child: Text(
                StringConstants.tc,
                style: AppTextStyles.labelDescriptionStyle,
              ),
            ),
            TermsAndPrivacyButton(),
          ],
        );
      }
    }))));
  }
}
