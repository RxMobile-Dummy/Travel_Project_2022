import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/search_hotel/presentation/widgets/search_hotel_page.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/date_time/date_time_extension.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.arrow_back,
                color: Colors.grey,
              )),
          title: Text(
            StringConstants.searchAppbarTitle,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                        child: SelectDates(),
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
                                        child: SelectDates(),
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
                        detail: "${cubit.rooms} ${StringConstants.roomText}",
                        iconData: Icons.person,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                    value: cubit,
                                    child: SelectRoom(),
                                  ));
                        }),
                    8.verticalSpace,
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          StringConstants.searchButtonLabel,
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
