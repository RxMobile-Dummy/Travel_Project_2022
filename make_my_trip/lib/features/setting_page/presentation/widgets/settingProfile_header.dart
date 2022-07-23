import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';

class SettingProfileHeader extends StatelessWidget {
  const SettingProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SettingPageCubit>().getUserData();
    BottomSheet bottomSheet = BottomSheet(
        onClosing: () {},
        builder: (context2) {
          return SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    BlocProvider.of<SettingPageCubit>(context).getFromCamera();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () {
                    BlocProvider.of<SettingPageCubit>(context).getFromGallery();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });

    return BlocBuilder<SettingPageCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnKnownToSuccess) {
          UserDetailsModel userModel = state.response;
          return Container(
              padding: const EdgeInsets.all(18),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          child: BlocBuilder<SettingPageCubit, BaseState>(
                            builder: (context, state) {
                              // return Container(
                              //  width: 100,
                              //  height: 100,
                              //  decoration: BoxDecoration(
                              //    shape: BoxShape.circle,
                              //    image: DecorationImage(
                              //      image: ,
                              //      fit: BoxFit.cover,
                              //    ),
                              //  ),
                              // );
                              //
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: (state is StateOnSuccess)
                                      ? Image.file(
                                          File(state.response),
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            userModel.userImage.toString(),
                                          ),
                                          radius: 50,
                                        ));
                            },
                          ),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return bottomSheet;
                                });
                          },
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MakeMyTripColors.colorWhite),
                              child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return bottomSheet;
                                        });
                                  },
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: MakeMyTripColors.accentColor,
                                    size: 28,
                                  )),
                            ))
                      ],
                    ),
                  )
                ],
              ));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
