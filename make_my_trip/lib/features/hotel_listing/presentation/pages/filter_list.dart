import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/filter_cubit_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../utils/constants/string_constants.dart';

class FilterList extends StatelessWidget {
  FilterList({Key? key, required this.arg}) : super(key: key);
  RangeValues defaultRange = const RangeValues(0, 0);
  List amenitiesList = [
    "Parking",
    "Healthy Breakfast",
    "AC",
    "Wifi",
    "Transportation",
    "Laundry",
    "Entertainment"
  ];
  List priceList = [
    "₹0 - ₹2000",
    "₹2001 - ₹4000",
    "₹4001 - ₹8000",
    "₹8001 - ₹10000",
    "₹10001 - ₹15000",
    "₹15000+",
  ];
  List ratingList = [
    2,
    3,
    4,
    5,
  ];
  final Map<String, dynamic> arg;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, BaseState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<FilterCubit>(context).resetFilters();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              titleSpacing: 0,
              elevation: 0,
              title: Text(
                StringConstants.filters,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                      child: TextButton(
                    child: Text(StringConstants.resetText.toUpperCase(),
                        style: AppTextStyles.infoContentStyle2),
                    onPressed: () {
                      BlocProvider.of<FilterCubit>(context).resetFilters();
                    },
                  )),
                ),
              ],
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FilterTitleWidget(filterTitle: "Rating"),
                  FilterMultipleSelectWidget(
                    filterList: ratingList,
                    rating: true,
                    type: "Rating",
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                    child: Divider(
                      color: MakeMyTripColors.color30gray,
                      thickness: 1,
                    ),
                  ),
                  const FilterTitleWidget(filterTitle: "Amenities"),
                  FilterMultipleSelectWidget(
                    filterList: amenitiesList,
                    type: "Amenities",
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
                    child: Divider(
                      color: MakeMyTripColors.color30gray,
                      thickness: 1,
                    ),
                  ),
                  FilterTitleWidget(filterTitle: "Price Range"),
                  FilterMultipleSelectWidget(
                    filterList: priceList,
                    type: "Price Range",
                  ),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Divider(
                      color: MakeMyTripColors.color30gray,
                      thickness: 1,
                    ),
                  ),
                  AllFiltersWidget(),
                  Center(
                    child: FractionallySizedBox(
                        widthFactor: .9,
                        child: CommonPrimaryButton(
                            text: StringConstants.doneTxt,
                            onTap: () {
                              Navigator.pop(context);
                            })),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AllFiltersWidget extends StatelessWidget {
  const AllFiltersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, BaseState>(
      builder: (context, state) {
        print(state);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              (state is StateOnResponseSuccess<Set>)
                  ? state.response.length
                  : 0,
              (index) => FilterContainer(
                rating: (state is StateOnResponseSuccess<Set> &&
                    state.response.toList()[index].runtimeType == int),
                backColor: MakeMyTripColors.colorWhite,
                textColor: MakeMyTripColors.colorBlack,
                iconColor: MakeMyTripColors.accentColor,
                borderColor: MakeMyTripColors.color30gray,
                filterText: (state is StateOnResponseSuccess<Set>)
                    ? state.response.toList()[index].toString()
                    : "",
              ),
            ),
          ),
        );
      },
    );
  }
}

class FilterTitleWidget extends StatelessWidget {
  const FilterTitleWidget({
    Key? key,
    required this.filterTitle,
  }) : super(key: key);

  final String filterTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        filterTitle,
        style: AppTextStyles.labelDetails
            .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

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
    return BlocBuilder<FilterCubit, BaseState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Wrap(
            children: List.generate(
                filterList.length,
                (index) => GestureDetector(
                      onTap: () {
                        BlocProvider.of<FilterCubit>(context)
                            .selectFilter(filterList[index], type);
                      },
                      child: FilterContainer(
                        rating: rating,
                        backColor: (state is StateOnResponseSuccess<Set> &&
                                state.response.contains(filterList[index]))
                            ? MakeMyTripColors.accentColor
                            : MakeMyTripColors.colorWhite,
                        textColor: (state is StateOnResponseSuccess<Set> &&
                                state.response.contains(filterList[index]))
                            ? MakeMyTripColors.colorWhite
                            : MakeMyTripColors.colorBlack,
                        iconColor: (state is StateOnResponseSuccess<Set> &&
                                state.response.contains(filterList[index]))
                            ? MakeMyTripColors.colorWhite
                            : MakeMyTripColors.accentColor,
                        borderColor: (state is StateOnResponseSuccess<Set> &&
                                state.response.contains(filterList[index]))
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

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    Key? key,
    this.rating,
    required this.filterText,
    required this.backColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColor,
  }) : super(key: key);

  final bool? rating;
  final String filterText;
  final Color backColor, textColor, iconColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, bottom: 12),
      padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: (rating == false || rating == null) ? 8 : 6),
      decoration: BoxDecoration(
          color: backColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (rating == false || rating == null)
              ? const SizedBox()
              : Icon(
                  Icons.star_rounded,
                  color: iconColor,
                ),
          4.horizontalSpace,
          Text(
            filterText,
            style: AppTextStyles.labelDescriptionStyle
                .copyWith(fontWeight: FontWeight.w500, color: textColor),
          ),
        ],
      ),
    );
  }
}
