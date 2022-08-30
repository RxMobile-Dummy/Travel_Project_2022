import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../cubits/hotel_list_cubit.dart';
import 'filter_container.dart';

class FilterMultipleSelectWidget extends StatelessWidget {
  const FilterMultipleSelectWidget({
    Key? key,
    required this.filterList,
    this.rating,
    required this.type,
  }) : super(key: key);

  final List filterList;
  final bool? rating;
  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelListCubit, BaseState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          child: Wrap(
            runSpacing: 12,
            spacing: 8,
            children: List.generate(
                filterList.length,
                (index) => GestureDetector(
                      onTap: () {
                        BlocProvider.of<HotelListCubit>(context)
                            .selectFilter(filterList[index], type);
                      },
                      child: FilterContainer(
                        rating: rating,
                        backColor: BlocProvider.of<HotelListCubit>(context)
                                .selectedFilter
                                .contains(filterList[index])
                            ? MakeMyTripColors.accentColor
                            : MakeMyTripColors.colorWhite,
                        textColor: BlocProvider.of<HotelListCubit>(context)
                                .selectedFilter
                                .contains(filterList[index])
                            ? MakeMyTripColors.colorWhite
                            : MakeMyTripColors.colorBlack,
                        iconColor: BlocProvider.of<HotelListCubit>(context)
                                .selectedFilter
                                .contains(filterList[index])
                            ? MakeMyTripColors.colorWhite
                            : MakeMyTripColors.accentColor,
                        borderColor: BlocProvider.of<HotelListCubit>(context)
                                .selectedFilter
                                .contains(filterList[index])
                            ? MakeMyTripColors.accentColor
                            : MakeMyTripColors.color30gray,
                        filterText: filterList[index].toString(),
                      ),
                    )),
          ),
        );
      },
    );
  }
}
