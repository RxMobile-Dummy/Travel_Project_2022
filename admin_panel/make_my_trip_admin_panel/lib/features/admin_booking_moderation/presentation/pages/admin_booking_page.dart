import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip_admin_panel/core/theme/text_styles.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/data/models/booking_moderation_model.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/cubit/admin_booking_moderation_cubit.dart';
import 'package:make_my_trip_admin_panel/features/admin_booking_moderation/presentation/widgets/filter_view_widget.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';
import 'package:make_my_trip_admin_panel/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_error_widget.dart';

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
    checkInDateController.text = DateTime.now().toString().substring(0, 10);
    context.read<AdminBookingModerationCubit>().setUpScrollController(
        scrollController,
        checkInDateVal: checkInDateController.text,
        checkOutDateVal: checkOutDateController.text,
        userName: bookingUserNameController.text,
        hotelName: bookingHotelNameController.text);
    return BlocConsumer<AdminBookingModerationCubit, BaseState>(
      listener: (context, state) {
        if (state is StateOnKnownToSuccess) {
          filterValue = state.response;
          if (filterValue == false) {
            bookingUserNameController.clear();
            bookingHotelNameController.clear();
            checkInDateController.text =
                DateTime.now().toString().substring(0, 10);
            checkOutDateController.clear();
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  StringConstants.bookingModerationLabel,
                  style: AppTextStyles.labelNameTextStyle
                      .copyWith(color: MakeMyTripColors.customDarkBlue),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 40,
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
                ),
                24.horizontalSpace,
                GestureDetector(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
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
                      Tooltip(
                          richMessage: TextSpan(
                            text: StringConstants.filterLabel,
                          ),
                          child: const Icon(Icons.filter_list_rounded)),
                      filterValue
                          ? const Text(
                              "*",
                              style: TextStyle(
                                  color: MakeMyTripColors.colorRed,
                                  fontSize: 20),
                            )
                          : const Text(''),
                    ],
                  ),
                ),
              ],
            ),
            32.verticalSpace,
            Container(
              color: MakeMyTripColors.customLightBlue,
              height: 40,
              child: Row(
                children: [
                  8.horizontalSpace,
                  Expanded(
                      flex: 2,
                      child: Text(
                        StringConstants.bookingIdLabel,
                        style: AppTextStyles.infoContentStyle,
                      )),
                  const Spacer(),
                  Expanded(
                      flex: 3,
                      child: Text(StringConstants.userNameLabel,
                          style: AppTextStyles.infoContentStyle)),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: Text(StringConstants.hotelDataLabel,
                          style: AppTextStyles.infoContentStyle)),
                  const Spacer(),
                  Expanded(
                      flex: 4,
                      child: Text(StringConstants.bookingDataLabel,
                          style: AppTextStyles.infoContentStyle)),
                  const Spacer(),
                  Expanded(
                      flex: 3,
                      child: Text(StringConstants.paymentDataLabel,
                          style: AppTextStyles.infoContentStyle)),
                ],
              ),
            ),
            24.verticalSpace,
            BlocBuilder<AdminBookingModerationCubit, BaseState>(
                builder: (context, state) {
              if (state is StateOnSuccess) {
                bookingModel = state.response;
              } else if (state is StateNoData) {
                return Expanded(
                  child: CommonErrorWidget(
                    imagePath: ImagePath.emptyFailureImg,
                    title: StringConstants.noBookingFound,
                    subTitle: StringConstants.refreshPageTxt,
                  ),
                );
              } else if (state is StateErrorGeneral ||
                  state is InternetDisconnected) {
                return Expanded(
                  child: CommonErrorWidget(
                    imagePath: state is InternetDisconnected
                        ? ImagePath.serverFailImg
                        : ImagePath.serverFailImg,
                    title: state is InternetDisconnected
                        ? StringConstants.internetFailureLabel
                        : null,
                    subTitle: state is InternetDisconnected
                        ? StringConstants.refreshPageTxt
                        : null,
                    onTap: () {
                      context
                          .read<AdminBookingModerationCubit>()
                          .getAllBookingListEvent(
                              page: 0,
                              checkInDateValue: checkInDateController.text,
                              checkOutDateValue: checkOutDateController.text,
                              userName: bookingUserNameController.text,
                              hotelName: bookingHotelNameController.text,
                              filter: filterValue);
                    },
                  ),
                );
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
                                        flex: 3,
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
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${StringConstants.checkInDateLabel}: ',
                                                  style: AppTextStyles
                                                      .infoContentStyle
                                                      .copyWith(fontSize: 14),
                                                ),
                                                Text(bookingModel[index]
                                                    .checkinDate!
                                                    .substring(
                                                        0,
                                                        bookingModel[index]
                                                            .checkinDate!
                                                            .indexOf('T'))),
                                              ],
                                            ),
                                            8.verticalSpace,
                                            Row(
                                              children: [
                                                Text(
                                                  '${StringConstants.checkOutDateLabel}: ',
                                                  style: AppTextStyles
                                                      .infoContentStyle
                                                      .copyWith(fontSize: 14),
                                                ),
                                                Text(bookingModel[index]
                                                    .checkoutDate!
                                                    .substring(
                                                        0,
                                                        bookingModel[index]
                                                            .checkoutDate!
                                                            .indexOf('T'))),
                                              ],
                                            ),
                                            8.verticalSpace,
                                            Row(
                                              children: [
                                                Text(
                                                  '${StringConstants.noOfRoomTxt}: ',
                                                  style: AppTextStyles
                                                      .infoContentStyle
                                                      .copyWith(fontSize: 14),
                                                ),
                                                Text(bookingModel[index]
                                                    .price!
                                                    .numberOfNights!
                                                    .toString()),
                                              ],
                                            ),
                                          ],
                                        )),
                                    const Spacer(),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${StringConstants.revenueLabel}: ',
                                                  style: AppTextStyles
                                                      .infoContentStyle
                                                      .copyWith(fontSize: 14),
                                                ),
                                                Text(
                                                  '${((bookingModel[index].price!.roomPrice! * bookingModel[index].price!.numberOfNights!) + bookingModel[index].price!.gst!).toString()}  INR',
                                                  style: const TextStyle(
                                                      color: MakeMyTripColors
                                                          .colorGreen),
                                                ),
                                              ],
                                            ),
                                            4.verticalSpace,
                                            SizedBox(
                                              width: 132,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                ),
                                                elevation: 5,
                                                color: bookingModel[index]
                                                            .status! ==
                                                        "success"
                                                    ? MakeMyTripColors
                                                        .colorLightGreen
                                                    : bookingModel[index]
                                                                .status! ==
                                                            "cancel"
                                                        ? MakeMyTripColors
                                                            .mandatoryRed
                                                        : MakeMyTripColors
                                                            .colorBlue,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 6.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${StringConstants.bookingStatusTxt}: ',
                                                        style: AppTextStyles
                                                            .infoContentStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                color: MakeMyTripColors
                                                                    .colorWhite),
                                                      ),
                                                      Text(
                                                        bookingModel[index]
                                                            .status!,
                                                        style: const TextStyle(
                                                            color:
                                                                MakeMyTripColors
                                                                    .colorWhite),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          if (index == bookingModel.length)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: CircularProgressIndicator(),
                            )
                        ],
                      );
                    }),
              );
            }),
          ]),
        );
      },
    );
  }
}
