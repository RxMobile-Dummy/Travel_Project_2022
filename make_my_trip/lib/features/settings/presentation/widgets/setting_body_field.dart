import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import '../../../../core/theme/make_my_trip_colors.dart';

class FromField extends StatelessWidget {
  FromField({
    Key? key,
    required this.labelName,
    required this.onTap,
    required this.data,
  }) : super(key: key);

  final String labelName;
  final VoidCallback onTap;
  final String data;

  final TextEditingController myData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myData.text = data;
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          fillColor: MakeMyTripColors.colorWhite,
          suffixIcon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: MakeMyTripColors.colorBlack,
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: MakeMyTripColors.color30gray)),
          labelText: labelName,
          labelStyle: AppTextStyles.infoContentStyle),
      onTap: onTap,
      controller: myData,
    );
  }
}

class SwitchField extends StatelessWidget {
  const SwitchField(
      {Key? key,
      required this.text,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: MakeMyTripColors.colorBlack),
          ),
          Switch(
            onChanged: onChanged,
            value: value,
            activeColor: MakeMyTripColors.color10gray,
          )
        ],
      ),
    );
  }
}

class EndingField extends StatelessWidget {
  const EndingField({Key? key, required this.txt, required this.onPressed})
      : super(key: key);

  final String txt;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          height: 50,
          color: MakeMyTripColors.color90gray,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  txt,
                  style: AppTextStyles.infoContentStyle,
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    color: MakeMyTripColors.color10gray)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
