import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/login/domain/model/user_model.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';

Widget SettingProfileHeader(BuildContext context) {
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
  //context.read<SettingPageCubit>().getUserData();
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
                      return BlocBuilder<SettingPageCubit, BaseState>(
                        builder: (context, state) {
                          if (state is StateOnKnownToSuccess<SettingPageData>) {
                            if (state.response.imageValue != null) {
                              String pikedImage =
                                  state.response.imageValue.toString();
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.file(
                                    File(pikedImage),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ));
                            } else {
                              UserDetailsModel? userDetailsModel =
                                  state.response.userValue;
                              return CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userDetailsModel?.userImage.toString() ?? "",
                                ),
                                radius: 50,
                              );
                            }
                          } else {
                            return CircleAvatar(
                              backgroundImage: AssetImage(
                                  ImagePath.userProfileImage1.toString()),
                              radius: 50,
                            );
                          }
                        },
                      );
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
}


                      // return BlocBuilder<SettingPageCubit, BaseState>(
                      //   builder: (context, state) {
                      //     if (state is StateOnKnownToSuccess) {
                      //       UserDetailsModel userDetailsModel = state.response;
                      //       return CircleAvatar(
                      //         backgroundImage: NetworkImage(
                      //           userDetailsModel.userImage.toString(),
                      //         ),
                      //         radius: 50,
                      //       );
                      //     } else if (state is StateOnSuccess) {
                      //       String pikedImage = state.response.toString();
                      //       return ClipRRect(
                      //           borderRadius: BorderRadius.circular(150),
                      //           child: Image.file(
                      //             File(pikedImage),
                      //             width: 100,
                      //             height: 100,
                      //             fit: BoxFit.cover,
                      //           ));
                      //     } else {
                      //       return Text('htt');
                      //     }
                      //   },
                      // );