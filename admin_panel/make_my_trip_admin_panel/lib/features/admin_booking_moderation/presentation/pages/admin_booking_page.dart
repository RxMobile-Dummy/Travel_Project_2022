import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

class AdminBookingPage extends StatelessWidget {
  AdminBookingPage({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  List<BookingModerationModel> bookingModel = [];
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<AdminBookingModerationCubit>.call().setUpScrollController(
        scrollController,
        checkInDateController.text,
        checkOutDateController.text);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    onChanged: (value) {
                      context
                          .read<AdminBookingModerationCubit>()
                          .searchList(value.toString());
                    },
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                24.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    context
                        .read<AdminBookingModerationCubit>()
                        .getAllBookingListEvent(checkInDateController.text,
                            checkOutDateController.text);
                  },
                  child: const Text(
                    "Filter",
                    style: AppTextStyles.infoContentStyle,
                  ),
                ),
              ],
            ),
            8.verticalSpace,
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
                    decoration: const InputDecoration(
                      hintText: 'Check_In_Date',
                      suffixIcon: Icon(Icons.calendar_month_sharp),
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
                    decoration: const InputDecoration(
                      hintText: 'Check_Out_Date',
                      suffixIcon: Icon(Icons.calendar_month_sharp),
                    ),
                  ),
                ),
              ],
            ),
            36.verticalSpace,
            Container(
              color: MakeMyTripColors.color10gray,
              height: 40,
              child: Row(
                children: [
                  8.horizontalSpace,
                  const Expanded(flex: 2, child: Text("Booking ID")),
                  const Spacer(),
                  const Expanded(flex: 4, child: Text("UserName")),
                  const Spacer(),
                  const Expanded(flex: 4, child: Text("Hotel Name")),
                  const Spacer(),
                  const Expanded(flex: 3, child: Text("check_In_Date")),
                  const Spacer(),
                  const Expanded(flex: 3, child: Text("Check_out_Date")),
                  const Spacer(),
                  const Expanded(flex: 2, child: Text("Revenue")),
                ],
              ),
            ),
            24.verticalSpace,
            BlocBuilder<AdminBookingModerationCubit, BaseState>(
                builder: (context, state) {
              if (state is StateOnSuccess) {
                bookingModel = state.response;
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: state.isMoreLoading!
                        ? bookingModel.length + 1
                        : bookingModel.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              8.horizontalSpace,
                              Expanded(
                                  flex: 2,
                                  child:
                                      Text(bookingModel[index].id.toString())),
                              const Spacer(),
                              Expanded(
                                  flex: 4,
                                  child: Text(bookingModel[index]
                                      .userdata!
                                      .first
                                      .userName!)),
                              const Spacer(),
                              Expanded(
                                  flex: 4,
                                  child: Text(bookingModel[index]
                                      .hoteldata!
                                      .first
                                      .hotelName!)),
                              const Spacer(),
                              Expanded(
                                  flex: 3,
                                  child: Text(bookingModel[index]
                                      .checkinDate!
                                      .substring(
                                          0,
                                          bookingModel[index]
                                              .checkinDate!
                                              .indexOf('T')))),
                              const Spacer(),
                              Expanded(
                                  flex: 3,
                                  child: Text(bookingModel[index]
                                      .checkoutDate!
                                      .substring(
                                          0,
                                          bookingModel[index]
                                              .checkoutDate!
                                              .indexOf('T')))),
                              const Spacer(),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                      '${bookingModel[index].price!.totalPrice!.toString()} Rs.')),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            })
          ]),
        ),
      ),
    );
  }
}
