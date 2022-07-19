import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/settings/presentation/widgets/setting_body_field.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          FromField(
            labelName: StringConstants.fullName,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const UpdateDialog(
                      name: StringConstants.fullName,
                      data: "Enter Name",
                    );
                  }).then((value) {
                if (value is String && value.isNotEmpty) {}
              });
            },
            data: "",
          ),
          18.verticalSpace,
          FromField(
            labelName: StringConstants.emailTxt,
            data: "",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return UpdateDialog(
                      name: StringConstants.emailTxt,
                      data: "Enter Email",
                    );
                  }).then((value) {
                if (value is String && value.isNotEmpty) {}
              });
            },
          ),
          18.verticalSpace,
          FromField(
            labelName: StringConstants.phone,
            data: "",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const UpdateDialog(
                      name: StringConstants.phone,
                      data: "Enter Phone",
                    );
                  }).then((value) {
                if (value is String && value.isNotEmpty) {}
              });
            },
          ),
        ],
      ),
    );
  }
}

class UpdateDialog extends StatefulWidget {
  final String name;
  final String data;

  const UpdateDialog({Key? key, required this.name, required this.data})
      : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.name),
      content: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .pop(controller.text == widget.data ? "" : controller.text);
          },
          style: ElevatedButton.styleFrom(
            primary: MakeMyTripColors.color10gray,
            //textStyle: Themes.lightTheme.textTheme.headline6),
          ),
          child: const Text(StringConstants.update),
        )
      ],
    );
  }
}
