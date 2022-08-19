import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/widgets/filter_view_widget.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';

class AdminBookingPage extends StatelessWidget {
  AdminBookingPage({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController bookingUserNameController =
      TextEditingController();
  final TextEditingController bookingHotelNameController =
      TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();
  List<BookingModerationModel> bookingModel = [];
  bool filterValue = false;

  @override
  Widget build(BuildContext context) {
    context.read<AdminBookingModerationCubit>().setUpScrollController(
        scrollController,
        date1: DateTime.now().toString().substring(0, 10));
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
                    decoration: InputDecoration(
                      hintText: StringConstants.searchHintTxt,
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                24.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return FilterViewWidget(
                              providerContext: context,
                              checkOutDateController: checkOutDateController,
                              bookingHotelNameController:
                                  bookingHotelNameController,
                              bookingUserNameController:
                                  bookingUserNameController,
                              checkInDateController: checkInDateController,
                              filterResetValue: filterValue);
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        StringConstants.filterLabel,
                        style: AppTextStyles.infoContentStyle,
                      ),
                      Text(
                        filterValue == true ? "*" : "",
                        style:
                            const TextStyle(color: MakeMyTripColors.colorRed),
                      )
                    ],
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
                  Expanded(
                      flex: 2, child: Text(StringConstants.bookingIdLabel)),
                  const Spacer(),
                  Expanded(flex: 4, child: Text(StringConstants.userNameLabel)),
                  const Spacer(),
                  Expanded(
                      flex: 4, child: Text(StringConstants.hotelNameLabel)),
                  const Spacer(),
                  Expanded(
                      flex: 3, child: Text(StringConstants.checkInDateLabel)),
                  const Spacer(),
                  Expanded(
                      flex: 3, child: Text(StringConstants.checkOutDateLabel)),
                  const Spacer(),
                  Expanded(flex: 2, child: Text(StringConstants.revenueLabel)),
                ],
              ),
            ),
            24.verticalSpace,
            BlocBuilder<AdminBookingModerationCubit, BaseState>(
                builder: (context, state) {
              if (state is StateOnSuccess) {
                bookingModel = state.response;
              } else if (state is StateNoData) {
                return Text(StringConstants.noBookingFound);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: state.isMoreLoading!
                        ? bookingModel.length + 1
                        : bookingModel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index != bookingModel.length)
                            SizedBox(
                              height: 100,
                              child: Card(
                                elevation: 5,
                                child: Row(
                                  children: [
                                    8.horizontalSpace,
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            bookingModel[index].id.toString())),
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
                                          '${bookingModel[index].price!.totalPrice!.toString()} Rs.',
                                          style: const TextStyle(
                                              color:
                                                  MakeMyTripColors.colorGreen),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          if (index == bookingModel.length)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: CircularProgressIndicator(),
                            )
                        ],
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
