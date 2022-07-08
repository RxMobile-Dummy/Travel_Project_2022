import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/continue_button.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/termsAndPrivacy.dart';
import 'package:make_my_trip/features/sign_up/presentation/widgets/text_field.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';


class SignUpOneView extends StatelessWidget {
  //final _formKey = GlobalKey<FormState>();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController conPass = TextEditingController();



  SignUpOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          // SizedBox(
          //   height: 30,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 25),
            child: Text(
              StringConstants.SignUp,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),

          TextFieldView(
            hintTextvar: StringConstants.fullname, textFieldViewController: fullname,obscuretext: false,
          ),
          TextFieldView(
            hintTextvar: StringConstants.email, textFieldViewController: email,obscuretext: false,
          ),
          TextFieldView(
            hintTextvar: StringConstants.password,
            textFieldViewController: pass,
            obscuretext: true,
          ),
          TextFieldView(
            hintTextvar: StringConstants.conpassowrd,
            textFieldViewController: conPass,
            obscuretext: true,
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                if (state is SignUpError) {
                  return Text(
                    state.error,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              }),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ContinueButton(onTap: (){
              BlocProvider.of<SignUpCubit>(context).checkSignUp(fullname.text,email.text,pass.text,conPass.text);
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0,bottom: 4.0),
            child: Text(
              StringConstants.tc,
              style: AppTextStyles.labelDescriptionStyle,
            ),
          ),
          TermsAndPrivacyButton(),
        ],
      ),
    )));
  }
}
