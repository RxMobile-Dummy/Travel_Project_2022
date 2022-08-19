import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

class FilterViewWidget extends StatelessWidget {
  const FilterViewWidget(
      {Key? key,
      required this.providerContext,
      required this.bookingUserNameController,
      required this.bookingHotelNameController,
      required this.checkInDateController,
      required this.checkOutDateController,
      required this.filterResetValue})
      : super(key: key);

  final TextEditingController bookingUserNameController;
  final TextEditingController bookingHotelNameController;
  final TextEditingController checkInDateController;
  final TextEditingController checkOutDateController;
  final bool filterResetValue;

  final BuildContext providerContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(StringConstants.filterLabel),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          12.verticalSpace,
          TextFormField(
            controller: bookingHotelNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: StringConstants.filterHotelNameLabel,
                hintText: StringConstants.filterHotelNameHint),
          ),
          12.verticalSpace,
          TextFormField(
            controller: bookingUserNameController,
            decoration: InputDecoration(
                labelText: StringConstants.filterUserNameLabel,
                hintText: StringConstants.filterUserNameHint),
          ),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: checkInDateController,
                  onTap: () async {
                    await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100))
                        .then((value) {
                      checkInDateController.text =
                          value.toString().substring(0, 10);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: StringConstants.checkInDateLabel,
                    hintText: StringConstants.checkInDateLabel,
                    suffixIcon: const Icon(Icons.calendar_month_sharp),
                  ),
                ),
              ),
              24.horizontalSpace,
              Expanded(
                flex: 1,
                child: TextFormField(
                  onTap: () async {
                    await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100))
                        .then((value) {
                      checkOutDateController.text =
                          value.toString().substring(0, 10);
                    });
                  },
                  controller: checkOutDateController,
                  decoration: InputDecoration(
                    labelText: StringConstants.checkOutDateLabel,
                    hintText: StringConstants.checkOutDateLabel,
                    suffixIcon: const Icon(Icons.calendar_month_sharp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              if (filterResetValue == true) {
                providerContext
                    .read<AdminBookingModerationCubit>()
                    .resetFilterEvent(false);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(filterResetValue == true
                ? StringConstants.resetTxt
                : StringConstants.cancelTxt)),
        ElevatedButton(
          child: Text(StringConstants.applyTxt),
          onPressed: () {
            providerContext
                .read<AdminBookingModerationCubit>()
                .getAllBookingListEvent(
                    filter: true,
                    page: 0,
                    checkInDateValue: checkInDateController.text,
                    checkOutDateValue: checkOutDateController.text,
                    userName: bookingUserNameController.text,
                    hotelName: bookingHotelNameController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
