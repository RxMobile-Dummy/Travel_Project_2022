import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../cubits/hotel_list_cubit.dart';
import 'filter_container.dart';

class AllFiltersWidget extends StatelessWidget {
  const AllFiltersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelListCubit, BaseState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              BlocProvider.of<HotelListCubit>(context).selectedFilter.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FilterContainer(
                  rating: BlocProvider.of<HotelListCubit>(context)
                          .selectedFilter
                          .toList()[index]
                          .runtimeType ==
                      int,
                  backColor: MakeMyTripColors.colorWhite,
                  textColor: MakeMyTripColors.colorBlack,
                  iconColor: MakeMyTripColors.accentColor,
                  borderColor: MakeMyTripColors.color30gray,
                  filterText: BlocProvider.of<HotelListCubit>(context)
                      .selectedFilter
                      .toList()[index]
                      .toString(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
