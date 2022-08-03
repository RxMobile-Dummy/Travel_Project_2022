import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_cubit.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_state.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/widgets/common_primary_button.dart';

class SelectRoom extends StatelessWidget {
  const SelectRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: MakeMyTripColors.colorWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              centerTitle: false,
              titleSpacing: 0,
              elevation: 0,
              title: Text(
                StringConstants.selectRoomAppbar,
              ),
              automaticallyImplyLeading: false,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Divider(
                color: MakeMyTripColors.colorLightGray,
                height: 2,
                thickness: 1),
            20.verticalSpace,
            RoomGuestContainer(
              title: StringConstants.selectRoomLabel,
            ),
            20.verticalSpace,
            RoomGuestContainer(
              title: StringConstants.selectAdultsLabel,
              subTitle: StringConstants.aboveAgeLabel,
            ),
            20.verticalSpace,
            RoomGuestContainer(
              title: StringConstants.selectChildrensLabel,
              subTitle: StringConstants.belowAgeLabel,
            ),
            20.verticalSpace,
            SizedBox(
              width: double.infinity,
              child: CommonPrimaryButton(
                  text: StringConstants.done,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomGuestContainer extends StatelessWidget {
  const RoomGuestContainer({
    Key? key,
    required this.title,
    this.subTitle,
  }) : super(key: key);

  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchHotelCubit>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
            text: TextSpan(
                text: title,
                style: AppTextStyles.mediumLabelStyle,
                children: [
              TextSpan(
                  text: (subTitle == null) ? "" : "\n$subTitle",
                  style: AppTextStyles.smallGrayTitleStyle)
            ])),
        Container(
            height: 32,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: MakeMyTripColors.color30gray),
                borderRadius: BorderRadius.circular(8)),
            child: BlocBuilder<SearchHotelCubit, SearchHotelState>(
              builder: (context, state) {
                int listOfItems = 20;
                if (title == StringConstants.selectRoomLabel) {
                  listOfItems = 20;
                } else if (title == StringConstants.selectAdultsLabel) {
                  listOfItems = cubit.rooms * 2;
                } else if (title == StringConstants.selectChildrensLabel) {
                  listOfItems = cubit.rooms * 3 + 1;
                }
                return DropdownButton(
                  menuMaxHeight: 250,
                  underline: 0.verticalSpace,
                  value: (title == StringConstants.selectRoomLabel)
                      ? cubit.rooms
                      : (title == StringConstants.selectAdultsLabel)
                          ? cubit.adults
                          : (title == StringConstants.selectChildrensLabel)
                              ? cubit.childrens
                              : cubit.rooms,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: MakeMyTripColors.accentColor,
                  ),
                  items: List.generate(listOfItems, (index) {
                    if (title != StringConstants.selectChildrensLabel) {
                      index += 1;
                    }
                    return DropdownMenuItem(
                        value: index, child: Text(index.toString()));
                  }),
                  onChanged: (int? value) {
                    if (title == StringConstants.selectRoomLabel) {
                      cubit.selectRooms(value!);
                    } else if (title == StringConstants.selectAdultsLabel) {
                      cubit.selectAdults(value!);
                    } else if (title == StringConstants.selectChildrensLabel) {
                      cubit.selectChildrens(value!);
                    }
                  },
                );
              },
            ))
      ],
    );
  }
}
