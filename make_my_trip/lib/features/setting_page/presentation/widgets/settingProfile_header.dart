import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/widgets/shimmer_user_profile.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import '../../../../utils/constants/string_constants.dart';

Widget settingProfileHeader(BuildContext context) {
  BottomSheet bottomSheet = BottomSheet(
      onClosing: () {},
      builder: (context2) {
        return SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Choose',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: MakeMyTripColors.colorBlack,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(StringConstants.camera),
                onTap: () {
                  context.read<SettingPageCubit>().getFromCamera();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(StringConstants.gallery),
                onTap: () {
                  context.read<SettingPageCubit>().getFromGallery();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
  return BlocBuilder<SettingPageCubit, BaseState>(builder: (context, state) {
    if (state is StateOnKnownToSuccess<SettingPageData>) {
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
                          if (state is StateOnKnownToSuccess<SettingPageData>) {
                            var userImage = state.response.userValue?.userImage;
                            if (state.response.imageValue != null &&
                                state.response.imageValue !=
                                    StringConstants.emptyString) {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(
                                    state.response.imageValue.toString()),
                                radius: 50,
                                backgroundColor:
                                    MakeMyTripColors.colorLightGray,
                              );
                            } else if (userImage == null) {
                              return const CircleAvatar(
                                backgroundImage:
                                    AssetImage(ImagePath.userProfileImage1),
                                radius: 50,
                              );
                            } else {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(userImage),
                                radius: 50,
                                backgroundColor:
                                    MakeMyTripColors.colorLightGray,
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MakeMyTripColors.accentColor,
                              border: Border.all(
                                  width: 3,
                                  color: MakeMyTripColors.colorWhite)),
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
                                color: MakeMyTripColors.colorWhite,
                                size: 18,
                              )),
                        ))
                  ],
                ),
              ),
              10.verticalSpace,
              Center(
                  child: Text(
                state.response.userValue?.userEmail.toString() ??
                    StringConstants.emptyString,
                style: AppTextStyles.infoContentStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ))
            ],
          ));
    }
    else{
      return 80.verticalSpace;
    }
  });
}
