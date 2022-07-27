import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/book_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/pages/booking_shimmer_page.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/room_categories/data/model/room_data_booking_post_model.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key, required this.arg}) : super(key: key);
  Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BaseState>(
      listener: (context, state) {
        if(state is StateOnKnownToSuccess){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_){
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.home,(route)=>false);
                });
                return AlertDialog(
                  elevation: 4,
                  title: Row(
                    children: [
                      Icon(Icons.check_circle,color: Colors.green,size: 18,),
                      Text("Booking Success!!"),
                    ],
                  ),
                );
              }
          );
        }
      },
      builder: (context, state) {
        if (state is StateOnSuccess<CustomState>) {
          HotelDetailModel? hotelDetailModel = state.response.hotelDetailModel;
          RoomDataPostModel? roomDataPostModel =
              arg['model'];
          return
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "Confirmation",
                  style: AppTextStyles.labelStyle.copyWith(fontSize: 24),
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Booking Details",
                      style: AppTextStyles.unselectedLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: MakeMyTripColors.color0gray,
                        boxShadow: [ BoxShadow(
                        // color: Colors.black,
                        blurRadius: 2.0,
                      ),]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotelDetailModel?.hotelName ?? 'Hotel Name',
                              style: AppTextStyles.infoContentStyle
                                  .copyWith(fontSize: 22),
                            ),
                            RatingBar.builder(
                                initialRating:
                                    hotelDetailModel?.rating?.toDouble() ?? 0.0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 15,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.3),
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: MakeMyTripColors.accentColor,
                                      size: 10,
                                    ),
                                onRatingUpdate: (rating) {}),
                            4.verticalSpace,
                            Text(
                              hotelDetailModel?.address?.addressLine ??
                                  "Address",
                              style: AppTextStyles.labelDetails.copyWith(fontSize: 14),
                            ),
                            4.verticalSpace,
                            const Divider(
                              color: MakeMyTripColors.color70gray,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Room Type",
                                  style: AppTextStyles.infoContentStyle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  roomDataPostModel?.roomType ?? "Room Type",
                                  style: AppTextStyles.labelDetails.copyWith(fontSize: 16),
                                )
                              ],
                            ),
                            const Divider(
                              color: MakeMyTripColors.color70gray,
                            ),
                            12.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Check In Date",
                                      style: AppTextStyles.infoLabelStyle.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                        roomDataPostModel?.checkinDate ??
                                            '--/--/----',
                                        style:
                                            AppTextStyles.unselectedLabelStyle)
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Check Out Date",
                                      style: AppTextStyles.infoLabelStyle.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      roomDataPostModel?.checkoutDate ??
                                          '--/--/----',
                                      style: AppTextStyles.unselectedLabelStyle,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Payment Summary",
                      style: AppTextStyles.unselectedLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: MakeMyTripColors.color0gray,
                          boxShadow: [ BoxShadow(
                            // color: Colors.black,
                            blurRadius: 2.0,
                          ),]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Room Rate",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '${roomDataPostModel?.price?.basePrice
                                          .toString()} ₹',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "No of Nights",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  roomDataPostModel?.price?.numberOfNights.toString() ?? '0',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '${roomDataPostModel?.price?.roomPrice.toString()} ₹' ,
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                            4.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GST (18%)",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '${roomDataPostModel?.price?.gst.toString()} ₹',
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
                                  "Offer",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  "- ${roomDataPostModel?.price?.discount.toString()}",
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
                                  "Grant Total",
                                  style: AppTextStyles.infoContentStyle,
                                ),
                                Text(
                                  '${roomDataPostModel?.price?.totalPrice
                                          .toString()} ₹',
                                  style: AppTextStyles.labelDetails,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              bottomNavigationBar: SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: CommonPrimaryButton(
                        text: "Book",
                        onTap: () {
                          context.read<BookingCubit>().roomBookPost(
                              roomDataPostModel!.hotelId!, roomDataPostModel);
                        })),
              ));
        } else {
          return ConfirmationPageShimmer();
        }
      },
    );
  }
}
