import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_cubit.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_state.dart';
import 'package:make_my_trip/utils/extensions/date_time/date_time_extension.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/navigation/route_info.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../utils/widgets/common_primary_button.dart';
import '../widgets/search_city_container.dart';
import '../widgets/search_hotel_page.dart';
import '../widgets/select_dates.dart';
import '../widgets/select_rooms.dart';

class SearchHotel extends StatelessWidget {
  SearchHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchHotelCubit>(context);
    return BlocListener<SearchHotelCubit, SearchHotelState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => true,
              arguments: {"route_name": RoutesName.wishList});
        } else if (state is AuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.wishList, (route) => true);
        }
      },
      child: Scaffold(
          backgroundColor: MakeMyTripColors.colorWhite,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              StringConstants.searchAppbarTitle,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<SearchHotelCubit>(context).goToWishlist();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<SearchHotelCubit, SearchHotelState>(
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(children: [
                      SearchCityContainer(
                        label: StringConstants.searchHotelContainerLabel
                            .toUpperCase(),
                        detail:
                            (cubit.city == null) ? "Select City" : cubit.city!,
                        subDetail: StringConstants.searchCountryName,
                        iconData: Icons.location_on_outlined,
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.search,
                              arguments: {"context": context});
                        },
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: SearchCityContainer(
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
                                          value:
                                              BlocProvider.of<SearchHotelCubit>(
                                                  context),
                                          child: const SelectDates(),
                                        )));
                              },
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: SearchCityContainer(
                              label: StringConstants
                                  .searchCheckOutContainerLabel
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
                                          value:
                                              BlocProvider.of<SearchHotelCubit>(
                                                  context),
                                          child: const SelectDates(),
                                        )));
                              },
                            ),
                          )
                        ],
                      ),
                      8.verticalSpace,
                      SearchCityContainer(
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
                              onTap: () {
                                var checkInDate = cubit.inTime
                                    .toString()
                                    .substring(0,
                                        cubit.inTime.toString().indexOf(" "));
                                var checkOutDate = cubit.outTime
                                    .toString()
                                    .substring(0,
                                        cubit.outTime.toString().indexOf(" "));
                                Navigator.of(context).pushNamed(
                                    RoutesName.hotelList,
                                    arguments: {
                                      'city_name': cubit.city!,
                                      'cin': checkInDate,
                                      'cout': checkOutDate,
                                      'no_of_room': cubit.rooms,
                                      'id': cubit.searchId,
                                      'type': cubit.type,
                                    });
                              },
                              text: StringConstants.searchButtonLabel)),
                    ]),
                  ),
                ),
              );
            },
          )),
    );
  }
}
