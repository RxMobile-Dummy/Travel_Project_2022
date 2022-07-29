import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../../../../core/navigation/route_info.dart';
import '../cubit/calendar_cubit.dart';
import '../cubit/calendar_state.dart';
import '../widgets/calendar_constant.dart';
import '../widgets/select_date_container.dart';

class CalendarPage extends StatelessWidget {
   CalendarPage({Key? key,required this.arg}) : super(key: key);
  Map<String, dynamic> arg;
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
            title: const Text(
              "Select Dates",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                    child: TextButton(
                  child: Text(
                    'reset'.toUpperCase(),
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
                            child: SelectDateContainer(
                              label: "CHECK-IN DATE",
                              detail: (cubit.inTime == null)
                                  ? "Select Date"
                                  : "${Constant.convertDate(cubit.inTime!)}",
                              subDetail: (cubit.inTime == null)
                                  ? ""
                                  : "${Constant.convertSubDate(cubit.inTime!)}",
                              iconData: Icons.calendar_today_rounded,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: SelectDateContainer(
                              label: "CHECK-OUT DATE",
                              detail: (cubit.outTime == null)
                                  ? "Select Date"
                                  : "${Constant.convertDate(cubit.outTime!)}",
                              subDetail: (cubit.outTime == null)
                                  ? ""
                                  : "${Constant.convertSubDate(cubit.outTime!)}",
                              iconData: Icons.calendar_today_rounded,
                              onTap: () {},
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print("object");
                            if (cubit.inTime != null && cubit.outTime != null) {
                              var checkInDate = cubit.inTime.toString().substring(0,cubit.inTime.toString().indexOf(" "));
                              var checkOutDate = cubit.outTime.toString().substring(0,cubit.outTime.toString().indexOf(" "));
                              Navigator.pushNamed(context,
                                  RoutesName.roomCategory,arguments:{'hotel_id':arg['hotel_id'],'cin':checkInDate,'cout':checkOutDate});

                            }
                          },
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
                          child: const Text(
                            'DONE',
                            style: TextStyle(fontSize: 18),
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
