import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class AdminBookingPage extends StatelessWidget {
  AdminBookingPage({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  final TextEditingController username = TextEditingController();
  final TextEditingController hotelname = TextEditingController();
  final TextEditingController date1 = TextEditingController();
  final TextEditingController date2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<AdminBookingModerationCubit>.call().setUpScrollController(
        scrollController, date1, date2, hotelname, username);
    return Scaffold(body: BlocBuilder<AdminBookingModerationCubit, BaseState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
                flex: 2,
                child: Drawer(
                  child: ListView.builder(
                    itemCount: StringConstants.drawerListTitle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(StringConstants.drawerListTitle[index]),
                      );
                    },
                  ),
                )),
            Expanded(
                flex: 8,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: username,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                        ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                child: Column(
                                  children: const [
                                    Text("Booking ID:"),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                )),
          ],
        );
      },
    ));
  }
}
