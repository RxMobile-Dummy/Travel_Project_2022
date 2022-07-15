import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/search_hotel/presentation/widgets/select_city_container.dart';
import 'package:make_my_trip/utils/extensions/date_time/date_time_extension.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../../../../core/theme/make_my_trip_colors.dart';
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
            title: Text(
              StringConstants.calenderPageTitle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                    child: TextButton(
                  child: Text(StringConstants.resetText.toUpperCase(),
                      style: AppTextStyles.infoContentStyle2),
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
                          border: Border.all(
                              color: MakeMyTripColors.colorLightGray)),
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
                          width: double.infinity,
                          child: CommonPrimaryButton(
                              text: StringConstants.introDone,
                              onTap: () {
                                if (cubit.inTime != null &&
                                    cubit.outTime != null) {
                                  Navigator.pop(context);
                                }
                              },
                              disable: (cubit.inTime == null ||
                                  cubit.outTime == null))),
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
