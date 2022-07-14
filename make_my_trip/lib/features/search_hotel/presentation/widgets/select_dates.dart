import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/search_hotel/presentation/widgets/select_city_container.dart';
import 'package:make_my_trip/utils/extensions/date_time/date_time_extension.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../../../../utils/constants/string_constants.dart';
import '../cubit/calender_cubit.dart';
import '../cubit/calender_state.dart';

class SelectDates extends StatelessWidget {
  const SelectDates({key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CalenderCubit>(context)..init();
    return BlocConsumer<CalenderCubit, CalenderState>(
      listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is DateSelectState) {
          cubit.init();
        }

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: () {
                  cubit.clearCalender();
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: Text(
              StringConstants.calenderPageTitle,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                    child: TextButton(
                  child: Text(
                    StringConstants.resetText.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    cubit.clearCalender();
                  },
                )),
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () {
              cubit.clearCalender();
              return Future.value(true);
            },
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400)),
                      child: ScrollableCleanCalendar(
                        calendarController: cubit.cleanCalendarController!,
                        layout: Layout.BEAUTY,
                        calendarCrossAxisSpacing: 0,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
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
                              onTap: () {},
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: SelectCityContainer(
                              label:
                                  StringConstants.searchCheckOutContainerLabel,
                              detail: (cubit.outTime == null)
                                  ? StringConstants.searchEmptyLabel
                                  : cubit.outTime!.getSearchDate(),
                              subDetail: (cubit.outTime == null)
                                  ? ""
                                  : "'${cubit.outTime!.getSearchSubDate()}",
                              iconData: Icons.calendar_today_rounded,
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                      8.verticalSpace,
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (cubit.inTime != null && cubit.outTime != null) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            StringConstants.introDone.toUpperCase(),
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                                (cubit.inTime != null && cubit.outTime != null)
                                    ? Colors.lightBlue
                                    : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
