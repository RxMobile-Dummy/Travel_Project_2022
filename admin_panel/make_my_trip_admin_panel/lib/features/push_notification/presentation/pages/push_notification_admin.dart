import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/presentation/cubit/push_notification_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

class PushNotificationAdminPanel extends StatelessWidget {
  const PushNotificationAdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fileName = "";
    var url = "";
    var registerUser = 0;
    var endUser = 0;

    final title = TextEditingController();
    final body = TextEditingController();

    return BlocBuilder<PushNotificationCubit, PushNotificationState>(
        builder: (context, state) {
      if (state is PushNotificationResponse) {
        fileName = state.fileName.toString();
        url = state.refUrl.toString();
        registerUser = state.registerUser ?? 1;
        endUser = state.endUser ?? 1;
      }
      return Scaffold(
        body: Center(
          child: SizedBox(
            height: 800,
            width: 800,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        StringConstants.pushNotification,
                        style: AppTextStyles.labelStyle2
                            .copyWith(color: MakeMyTripColors.colorBlack),
                      )),
                      const Align(
                        alignment: AlignmentDirectional.center,
                      ),
                      32.verticalSpace,
                      TextFormField(
                        controller: title,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.title),
                            hintText: StringConstants.title,
                            labelText: StringConstants.title),
                      ),
                      20.verticalSpace,
                      TextFormField(
                        controller: body,
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: StringConstants.body,
                          prefixIcon: const Icon(Icons.text_fields),
                          hintText: StringConstants.body,
                        ),
                      ),
                      25.verticalSpace,
                      Text(StringConstants.uploadImage,
                          style: AppTextStyles.infoContentStyle),
                      20.verticalSpace,
                      Center(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 220,
                            width: 500,
                            child: url.isNotEmpty
                                ? Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    ImagePath.defaultImg,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          10.verticalSpace,
                          fileName.isNotEmpty
                              ? Text(fileName)
                              : Text(StringConstants.pleasUploadImage)
                        ],
                      )),
                      8.verticalSpace,
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<PushNotificationCubit>(context)
                                  .getImagefromDevice(registerUser, endUser);
                            },
                            child: Text(
                              StringConstants.uploadImage,
                              style: AppTextStyles.infoContentStyle5,
                            ),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(StringConstants.toRegisteredUser),
                          Radio(
                            value: registerUser,
                            groupValue: 1,
                            activeColor: MakeMyTripColors.accentColor,
                            onChanged: (value) {
                              BlocProvider.of<PushNotificationCubit>(context)
                                  .setRadioButton(fileName, url, 1, 0);
                            },
                          ),
                          40.horizontalSpace,
                          Text(StringConstants.toEndUser),
                          Radio(
                            value: endUser,
                            groupValue: 1,
                            activeColor: MakeMyTripColors.accentColor,
                            onChanged: (value) {
                              BlocProvider.of<PushNotificationCubit>(context)
                                  .setRadioButton(fileName, url, 0, 1);
                            },
                          )
                        ],
                      ),
                      BlocBuilder<PushNotificationCubit, PushNotificationState>(
                          builder: (context, state) {
                        if (state is ErrorState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  right: 20,
                                ),
                                child: Text(
                                  state.error,
                                  style: const TextStyle(
                                      color: MakeMyTripColors.colorRedDark),
                                ),
                              )
                            ],
                          );
                        } else {
                          return 10.verticalSpace;
                        }
                      }),
                      Center(
                          child: SizedBox(
                        height: 50,
                        width: 700,
                        child: ElevatedButton(
                            onPressed: () {
                              if (registerUser == 1) {
                                BlocProvider.of<PushNotificationCubit>(context)
                                    .registeredUserPushNotification(
                                        title.text.toString().trim(),
                                        body.text.toString(),
                                        url);
                              }
                              if (endUser == 1) {
                                BlocProvider.of<PushNotificationCubit>(context)
                                    .endUserPushNotification(
                                        title.text.toString().trim(),
                                        body.text.toString(),
                                        url,
                                        endUser);
                              }
                            },
                            child: Text(
                              StringConstants.sendNotification,
                              style: AppTextStyles.infoContentStyle,
                            )),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
