import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/constants/image_path.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/widgets/common_error_widget.dart';
import '../../../../utils/widgets/common_primary_button.dart';
import '../../../user_history/data/model/user_history_model.dart';
import '../../../user_history/presentation/cubit/user_history_cubit.dart';
import '../cubit/cancel_booking_cubit.dart';
import 'history_detail_page_shimmer.dart';

class BookingHistoryDetailBody extends StatelessWidget {
  BookingHistoryDetailBody(this.userHistoryModel, {Key? key}) : super(key: key);
  UserHistoryModel userHistoryModel;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('cancellationPolicy');
    return BlocBuilder<UserHistoryCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          return Scaffold(
            bottomNavigationBar: userHistoryModel.status == "success"
                ? SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: CommonPrimaryButton(
                            text: StringConstants.cancelBooking,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext _) {
                                  return AlertDialog(
                                    title:
                                        Text(StringConstants.cancelAreYouSure),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text("YES"),
                                        onPressed: () {
                                          context
                                              .read<CancelBookingCubit>()
                                              .cancelBooking(
                                                  userHistoryModel.bookingId);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            })))
                : const SizedBox(),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverLayoutBuilder(builder: (context, constraints) {
                  final scroll = constraints.scrollOffset > 145;
                  return SliverAppBar(
                    iconTheme: IconThemeData(
                      color: scroll
                          ? MakeMyTripColors.colorBlack
                          : MakeMyTripColors
                              .colorWhite, //change your color here
                    ),
                    snap: false,
                    pinned: true,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(StringConstants.bookingHistoryDetail,
                          style: TextStyle(
                            color: scroll
                                ? MakeMyTripColors.colorBlack
                                : MakeMyTripColors.colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ) //TextStyle
                          ), //Text
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(userHistoryModel
                                .images!.first.imageUrl
                                .toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ),
                    expandedHeight: 230,
                    backgroundColor: MakeMyTripColors.colorWhite,
                  );
                }),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 16,
                                    child: Text(
                                      userHistoryModel.hotelName.toString(),
                                      style: AppTextStyles.labelStyle
                                          .copyWith(fontSize: 21),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      "₹ ${userHistoryModel.price.toString()}",
                                      style: AppTextStyles.labelStyle.copyWith(
                                          fontSize: 18,
                                          color: MakeMyTripColors.accentColor),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 8.0),
                            child: Text(
                              userHistoryModel.address!.addressLine.toString(),
                              style: AppTextStyles.infoContentStyle
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          12.verticalSpace,
                          Text(
                            StringConstants.bookingDetails,
                            style:
                                AppTextStyles.labelStyle.copyWith(fontSize: 18),
                          ),
                          Column(
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(Icons.book,
                                    color: MakeMyTripColors.accentColor),
                                title: Text(
                                  StringConstants.bookedDate,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(
                                    userHistoryModel.bookedDate!.substring(
                                        0,
                                        userHistoryModel.checkingDate!
                                            .indexOf('T')),
                                    style: AppTextStyles.smallBlackTitleStyle),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(
                                  Icons.logout,
                                  color: MakeMyTripColors.accentColor,
                                ),
                                title: Text(
                                  StringConstants.checkIncheckOut,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(
                                    '${userHistoryModel.checkingDate!.substring(0, userHistoryModel.checkingDate!.indexOf('T'))} - ${userHistoryModel.checkoutDate!.substring(0, userHistoryModel.checkoutDate!.indexOf('T'))}',
                                    style: AppTextStyles.smallBlackTitleStyle),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(
                                  Icons.nightlight_round,
                                  color: MakeMyTripColors.accentColor,
                                ),
                                title: Text(
                                  StringConstants.totalNights,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(
                                  userHistoryModel.numberOfNights.toString(),
                                  style: AppTextStyles.smallBlackTitleStyle,
                                ),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(
                                  Icons.bed_outlined,
                                  color: MakeMyTripColors.accentColor,
                                ),
                                title: Text(
                                  StringConstants.totalRooms,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(
                                    userHistoryModel.noOfRoom.toString(),
                                    style: AppTextStyles.smallBlackTitleStyle),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(
                                  Icons.price_check,
                                  color: MakeMyTripColors.accentColor,
                                ),
                                title: Text(
                                  StringConstants.roomPrice,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(
                                    userHistoryModel.roomPrice.toString(),
                                    style: AppTextStyles.smallBlackTitleStyle),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(Icons.discount,
                                    color: MakeMyTripColors.accentColor),
                                title: Text(
                                  StringConstants.discount,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(
                                    userHistoryModel.discount.toString(),
                                    style: AppTextStyles.smallBlackTitleStyle),
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 12.0, right: 0.0),
                                leading: const Icon(Icons.local_atm_sharp,
                                    color: MakeMyTripColors.accentColor),
                                title: Text(
                                  StringConstants.gst,
                                  style: AppTextStyles.infoContentStyle
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                ),
                                subtitle: Text(userHistoryModel.gst.toString(),
                                    style: AppTextStyles.smallBlackTitleStyle),
                              ),
                              userHistoryModel.status == "cancel"
                                  ? Text(StringConstants.yourBookingIsCancel,
                                      style: const TextStyle(
                                          color: MakeMyTripColors.colorRedDark,
                                          fontWeight: FontWeight.bold))
                                  : const SizedBox()
                            ],
                          ),
                          12.verticalSpace,
                          userHistoryModel.status == "success"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        StringConstants.cancellationPolicy,
                                        style: AppTextStyles.labelStyle
                                            .copyWith(fontSize: 18),
                                      ),
                                    ),
                                    6.verticalSpace,
                                    FutureBuilder(
                                        future: users
                                            .doc("sTtV4Q0ORYzCUVBQqpdP")
                                            .get(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            return Center(
                                              child: SingleChildScrollView(
                                                child: Html(
                                                    data: snapshot.data
                                                        ?.get("content")),
                                              ),
                                            );
                                          } else {
                                            return 1.verticalSpace;
                                          }
                                        })
                                  ],
                                )
                              : const SizedBox()
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ))
              ], //<Widget>[]
            ),
          );
        } else if (state is StateErrorGeneral) {
          return CommonErrorWidget(
              imagePath: ImagePath.serverFailImage,
              subTitle: StringConstants.serverFail,
              title: StringConstants.emptyString);
        } else if (state is StateLoading) {
          return const HistoryDetailPageShimmer();
        } else {
          return const Center(child: Text(StringConstants.noDatatxt));
        }
      },
    );
  }
}
