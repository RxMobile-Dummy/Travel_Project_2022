import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

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
  const BookingHistoryDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHistoryCubit, BaseState>(
      builder: (context, state) {
        if (state is StateOnSuccess) {
          List<UserHistoryModel> userHistoryModel = state.response;
          return
            Scaffold(
                bottomNavigationBar: SafeArea(
            child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: CommonPrimaryButton(
        text: StringConstants.cancelBooking,
        onTap: () {
        BlocProvider.of<CancelBookingCubit>(context)
            .cancelBooking(userHistoryModel.first.bookingId);
        }
        )
        )
        ),
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
            .first.images!.first.imageUrl
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
        padding: const EdgeInsets.fromLTRB(
        0, 15, 0, 0),
        child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
        Expanded(
        flex: 16,
        child: Text(
        userHistoryModel.first.hotelName
            .toString(),
        style: AppTextStyles.labelStyle
            .copyWith(fontSize: 21),
        )),
        Expanded(
        flex: 5,
        child: Text(
        userHistoryModel.first.price
            .toString(),
        style: AppTextStyles.labelStyle
            .copyWith(fontSize: 18),
        )),
        ],
        ),
        ),
        Padding(
        padding: const EdgeInsets.only(
        left: 0.0, right: 0.0, top: 8.0),
        child: Text(
        userHistoryModel.first.address!
            .addressLine
            .toString(),
        style: AppTextStyles.infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w500),
        ),
        ),
        12.verticalSpace,
        Text(
        StringConstants.bookingDetails,
        style: AppTextStyles.labelStyle
            .copyWith(fontSize: 18),
        ),
        Container(
        height: 300,
        width: double.infinity,
        child: ListView(
        children: [
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(Icons.book),
        title: Text(
        StringConstants.bookedDate,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: const Text("18/06/2022",
        style:
        AppTextStyles
            .smallBlackTitleStyle),
        ),
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(
        Icons
            .check_circle_outline_outlined),
        title: Text(
        StringConstants.checkIncheckOut,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: Text(
        '${userHistoryModel.first
            .checkingDate!.substring(0,
        userHistoryModel.first
            .checkingDate!.indexOf(
        'T'))} - ${userHistoryModel
            .first.checkoutDate!
            .substring(0,
        userHistoryModel.first
            .checkoutDate!.indexOf(
        'T'))}',
        style:
        AppTextStyles
            .smallBlackTitleStyle),
        ),
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(
        Icons.nightlight_round),
        title: Text(
        StringConstants.totalNights,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: const Text(
        "1",
        style: AppTextStyles
            .smallBlackTitleStyle,
        ),
        ),
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(
        Icons.room_service),
        title: Text(
        StringConstants.totalRooms,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: const Text("3",
        style:
        AppTextStyles
            .smallBlackTitleStyle),
        ),
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(
        Icons.price_check),
        title: Text(
        StringConstants.roomPrice,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: const Text("₹ 10459",
        style:
        AppTextStyles
            .smallBlackTitleStyle),
        ),
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(Icons.discount),
        title: Text(
        StringConstants.discount,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: const Text("₹ 846",
        style:
        AppTextStyles
            .smallBlackTitleStyle),
        ),
        ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(
        left: 12.0, right: 0.0),
        leading: const Icon(
        Icons.local_atm_sharp),
        title: Text(
        StringConstants.gst,
        style: AppTextStyles
            .infoContentStyle
            .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16),
        ),
        subtitle: const Text("₹ 600",
        style:
        AppTextStyles
            .smallBlackTitleStyle),
        ),
        ],
        ),
        ),
        12.verticalSpace,
        Text(
        StringConstants.cancellationPolicy,
        style: AppTextStyles.labelStyle
            .copyWith(fontSize: 18),
        ),
        6.verticalSpace,
        Container(
        height: 300,
        color: Colors.grey,
        )
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
        title: StringConstants.serverFail,
        statusCode: StringConstants.emptyString);
        } else if (state is StateLoading) {
        return const HistoryDetailPageShimmer();
        } else {
        return const Center(child: Text(StringConstants.noDatatxt));
        }
      },
    );
  }
}
