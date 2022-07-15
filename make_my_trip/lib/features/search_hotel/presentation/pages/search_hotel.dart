import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/search_hotel/presentation/widgets/search_hotel_page.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/date_time/date_time_extension.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../cubit/calender_cubit.dart';
import '../cubit/calender_state.dart';
import '../widgets/select_city_container.dart';
import '../widgets/select_dates.dart';
import '../widgets/select_rooms.dart';

class SearchHotel extends StatelessWidget {
  const SearchHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CalenderCubit>(context);
    return Scaffold(
        backgroundColor: MakeMyTripColors.colorWhite,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            StringConstants.searchAppbarTitle,
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: MakeMyTripColors.colorBlack,
                    ),
                    Text(StringConstants.whishlistText),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CalenderCubit, CalenderState>(
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(children: [
                    SelectCityContainer(
                      label: StringConstants.searchHotelContainerLabel
                          .toUpperCase(),
                      detail: "Ahmedabad",
                      subDetail: StringConstants.searchCountryName,
                      iconData: Icons.location_on_outlined,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value:
                                      BlocProvider.of<CalenderCubit>(context),
                                  child: SearchHotelPage(),
                                )));
                      },
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: SelectCityContainer(
                            label: StringConstants.searchCheckInContainerLabel
                                .toUpperCase(),
                            detail: (cubit.inTime == null)
                                ? StringConstants.searchEmptyLabel
                                : cubit.inTime!.getSearchDate(),
                            subDetail: (cubit.inTime == null)
                                ? ""
                                : "'${cubit.inTime!.getSearchSubDate()}",
                            iconData: Icons.calendar_today_rounded,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<CalenderCubit>(
                                            context),
                                        child: const SelectDates(),
                                      )));
                            },
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: SelectCityContainer(
                            label: StringConstants.searchCheckOutContainerLabel
                                .toUpperCase(),
                            detail: (cubit.outTime == null)
                                ? StringConstants.searchEmptyLabel
                                : cubit.outTime!.getSearchDate(),
                            subDetail: (cubit.outTime == null)
                                ? ""
                                : "'${cubit.outTime!.getSearchSubDate()}",
                            iconData: Icons.calendar_today_rounded,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: BlocProvider.of<CalenderCubit>(
                                            context),
                                        child: const SelectDates(),
                                      )));
                            },
                          ),
                        )
                      ],
                    ),
                    8.verticalSpace,
                    SelectCityContainer(
                        label: StringConstants.searchRoomContainerLabel
                            .toUpperCase(),
                        // detail: "1 Room, 2 Adults",
                        detail:
                            "${cubit.rooms} ${StringConstants.roomText}, ${cubit.adults} ${StringConstants.adultText} ${(cubit.childrens != 0) ? ',' : ''} ${(cubit.childrens != 0) ? cubit.childrens : ''} ${(cubit.childrens != 0) ? StringConstants.childrenText : ''}",
                        iconData: Icons.person,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                    value: cubit,
                                    child: const SelectRoom(),
                                  ));
                        }),
                    8.verticalSpace,
                    SizedBox(
                        width: double.infinity,
                        child: CommonPrimaryButton(
                            onTap: () {},
                            text: StringConstants.searchButtonLabel))
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
