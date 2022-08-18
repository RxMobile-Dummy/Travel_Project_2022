import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

class AdminBookingPage extends StatelessWidget {
  AdminBookingPage({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  final TextEditingController username = TextEditingController();
  final TextEditingController hotelname = TextEditingController();
  final TextEditingController date1 = TextEditingController();
  final TextEditingController date2 = TextEditingController();
  List<BookingModerationModel> bookingModel = [];

  @override
  Widget build(BuildContext context) {
    context.read<AdminBookingModerationCubit>.call().setUpScrollController(
        scrollController, date1, date2, hotelname, username);
    return Scaffold(body: BlocBuilder<AdminBookingModerationCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          bookingModel = state.response;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: username,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: username,
                        decoration: const InputDecoration(
                          hintText: 'Check_In_Date',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: username,
                        decoration: const InputDecoration(
                          hintText: 'Check_Out_Date',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  child: Row(
                    children: const [
                      Expanded(flex: 2, child: Text("Booking ID")),
                      Expanded(flex: 4, child: Text("UserName")),
                      Expanded(flex: 4, child: Text("Hotel Name")),
                      Expanded(flex: 3, child: Text("check_In_Date")),
                      Expanded(flex: 3, child: Text("Check_out_Date")),
                      Expanded(flex: 2, child: Text("Revenue")),
                    ],
                  ),
                ),
                ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: state.isMoreLoading!
                        ? bookingModel.length + 1
                        : bookingModel.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(bookingModel[index].id.toString())),
                            Expanded(
                                flex: 4,
                                child: Text(bookingModel[index]
                                    .userdata!
                                    .first
                                    .userName!)),
                            Expanded(
                                flex: 4,
                                child: Text(
                                    bookingModel[index].hotelId.toString())),
                            Expanded(
                                flex: 3,
                                child: Text(bookingModel[index].id.toString())),
                            Expanded(
                                flex: 3,
                                child: Text(bookingModel[index].id.toString())),
                            Expanded(
                                flex: 2,
                                child: Text(bookingModel[index].id.toString())),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      },
    ));
  }
}
