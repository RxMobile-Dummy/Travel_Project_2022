import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/booking/data/model/booking_model.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/book_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/payment_integeration_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/pages/booking_shimmer_page.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../utils/widgets/progress_loader.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key, required this.arg}) : super(key: key);

  Map<String, dynamic> arg;
  BookingModel? bookingModel;

  @override
  Widget build(BuildContext context) {
    var detail = arg["model"] as RoomDataPostModel;
    return BlocConsumer<PaymentCubit, BaseState>(
      listener: (context, state) {
        if (state is StateShowSearching) {
          ProgressDialog.hideLoadingDialog(context);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RoutesName.home, (route) => false);
                });
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                  elevation: 4,
                  title: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.6,
                        child: Image.asset(
                          ImagePath.confirmSuccess,
                        ),
                      ),
                      30.verticalSpace,
                      Text(
                        StringConstants.confirmBooking,
                        style: const TextStyle(
                            color: MakeMyTripColors.accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      25.verticalSpace,
                    ],
                  ),
                );
              });
        } else if (state is StateLoading) {
          ProgressDialog.showLoadingDialog(context, message: "Please wait");
        } else if (state is StateErrorGeneral) {
          ProgressDialog.hideLoadingDialog(context);
          BlocProvider.of<PaymentCubit>(context).bookingConfirm(detail.hotelId!,
              detail.checkinDate!, detail.checkoutDate!, detail.roomId!);
        } else {
          ProgressDialog.hideLoadingDialog(context);
        }
      },
      builder: (context, state) {
        if (state is StateOnSuccess) {
          bookingModel = state.response;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                StringConstants.confirMation,
                style: AppTextStyles.labelStyle.copyWith(fontSize: 24),
              ),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      StringConstants.bookingDetails,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.unselectedLabelStyle
                          .copyWith(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: MakeMyTripColors.colorWhite,
                          boxShadow: const [
                            BoxShadow(
                              // color: Colors.black,
                              blurRadius: 1.0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    bookingModel?.hotelName ?? 'Hotel Name',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.infoContentStyle
                                        .copyWith(fontSize: 22),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: MakeMyTripColors.colorBlue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star_rate_rounded,
                                            size: 18,
                                            color: MakeMyTripColors.colorWhite),
                                        Text(
                                          bookingModel?.rating
                                                  ?.toDouble()
                                                  .toString() ??
                                              "0.0",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  MakeMyTripColors.colorWhite),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            6.verticalSpace,
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    bookingModel?.address ?? "Address",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.labelDetails.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            4.verticalSpace,
                            const Divider(
                              color: MakeMyTripColors.color70gray,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    StringConstants.roomType,
                                    style: AppTextStyles.infoContentStyle
                                        .copyWith(fontSize: 18),
                                  ),
                                  Text(
                                    "${bookingModel?.roomId?.join(",")}",
                                    style: AppTextStyles.labelDetails.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: MakeMyTripColors.color70gray,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Check In",
                                        style: AppTextStyles.infoLabelStyle
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                          bookingModel?.checkInDate ??
                                              '--/--/----',
                                          style: AppTextStyles
                                              .unselectedLabelStyle)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Check Out",
                                        style: AppTextStyles.infoLabelStyle
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        bookingModel?.checkOutDate ??
                                            '--/--/----',
                                        style:
                                            AppTextStyles.unselectedLabelStyle,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Payment Summary",
                      style: AppTextStyles.unselectedLabelStyle
                          .copyWith(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: MakeMyTripColors.colorWhite,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  StringConstants.roomRate,
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '₹ ${bookingModel?.roomPrice}',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  StringConstants.noOfNight,
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  bookingModel?.noOfDays.toString() ?? '0',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  StringConstants.subTotal,
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '₹ ${bookingModel?.subTotal}',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${StringConstants.gst} (${bookingModel?.gstPercentage}%)",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '₹ ${bookingModel?.gst}',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            const Divider(
                              color: MakeMyTripColors.color70gray,
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${StringConstants.offer} (${bookingModel?.discountPercentage}%)",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  "- ₹ ${bookingModel?.offer}",
                                  style: AppTextStyles.labelDetails.copyWith(
                                      color: MakeMyTripColors.colorGreen,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            4.verticalSpace,
                            const Divider(
                              color: MakeMyTripColors.color70gray,
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  StringConstants.grandTotal,
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '₹ ${bookingModel?.total}',
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: Text(
                      StringConstants.warningBooking,
                      style: AppTextStyles.unselectedLabelStyle.copyWith(
                          fontSize: 16, color: MakeMyTripColors.colorRed),
                    ),
                  )
                ],
              ),
            )),
            bottomNavigationBar: SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: CommonPrimaryButton(
                      text: StringConstants.book,
                      onTap: () {
                        context.read<PaymentCubit>().paymentConfirm(20);
                        //context.read<BookingCubit>().roomBookPost(roomDataPostModel!.hotelId!, roomDataPostModel);
                      })),
            ),
          );
        } else {
          return const ConfirmationPageShimmer();
        }
      },
    );
  }
}
