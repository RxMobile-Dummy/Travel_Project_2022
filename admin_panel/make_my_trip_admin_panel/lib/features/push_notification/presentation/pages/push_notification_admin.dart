import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/push_notification/presentation/cubit/push_notification_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

class PushNotificationAdminPanel extends StatelessWidget {
  const PushNotificationAdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fileName = "";
    var url = "";
    var broadCast = 0;
    var endUser = 0;
    final title = TextEditingController();
    final body = TextEditingController();
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
                          "Push Notification",
                          style: AppTextStyles.labelStyle2
                              .copyWith(color: Colors.black),
                        )),
                    const Align(
                      alignment: AlignmentDirectional.center,
                    ),
                    32.verticalSpace,
                    TextFormField(
                      controller: title,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        hintText: "Title",
                        labelText: "Title",
                      ),
                    ),
                    20.verticalSpace,
                    TextFormField(
                      controller: body,
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Body",
                        prefixIcon: Icon(Icons.text_fields),
                        hintText: "Body",
                      ),
                    ),
                    25.verticalSpace,
                    const Text("Upload a image",
                        style: AppTextStyles.infoContentStyle),
                    20.verticalSpace,
                    Center(
                      child: BlocBuilder<PushNotificationCubit,
                          PushNotificationState>(
                        builder: (context, state) {
                          if (state is PushNotificationResponse) {
                            fileName = state.fileName.toString();
                            url = state.refurl.toString();
                            BlocProvider.of<PushNotificationCubit>(
                                context)
                                .setRadioButton(0, 0);
                          }
                          return Column(
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
                                  : const Text("Please upload image")
                            ],
                          );
                        },
                      ),
                    ),
                    8.verticalSpace,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<PushNotificationCubit>(context)
                                .getImagefromDevice();
                          },
                          child: const Text(
                            "Upload image",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    BlocBuilder<PushNotificationCubit,PushNotificationState>(
                      builder: (context, state) {
                        if (state is SetRadioButton) {
                          broadCast = state.broadCast;
                          endUser = state.endUser;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('As BroadCast'),
                              Radio(
                                value: state.broadCast,
                                groupValue: 1,
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  BlocProvider.of<PushNotificationCubit>(
                                      context)
                                      .setRadioButton(1, 0);
                                },
                              ),
                              40.horizontalSpace,
                              Text('To end user'),
                              Radio(
                                value: state.endUser,
                                groupValue: 1,
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  BlocProvider.of<PushNotificationCubit>(
                                      context)
                                      .setRadioButton(0, 1);
                                },
                              )
                            ],
                          );
                        }
                        else{
                          return SizedBox();
                        }


                      }
                    ),
                    Center(
                        child: Container(
                          height: 50,
                          width: 700,
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<PushNotificationCubit>(context).broadCastPushNotification(title,body,url,broadCast);
                              },
                              child: const Text("Send Notification")),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
