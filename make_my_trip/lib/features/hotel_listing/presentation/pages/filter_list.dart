import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../utils/constants/string_constants.dart';
import '../widgets/filter_all_filter_widget.dart';
import '../widgets/filter_container.dart';
import '../widgets/filter_multiple_select_widget.dart';
import '../widgets/filter_title_widget.dart';

class FilterList extends StatelessWidget {
  FilterList({Key? key, required this.arg}) : super(key: key);
  RangeValues defaultRange = const RangeValues(0, 0);

  final Map<String, dynamic> arg;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelListCubit, BaseState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<HotelListCubit>(context).resetFilters();
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
                      BlocProvider.of<HotelListCubit>(context).resetFilters();
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
                    filterList:
                        BlocProvider.of<HotelListCubit>(context).ratingList,
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
                    filterList:
                        BlocProvider.of<HotelListCubit>(context).amenitiesList,
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
                  const FilterTitleWidget(filterTitle: "Price Range"),
                  FilterMultipleSelectWidget(
                    filterList:
                        BlocProvider.of<HotelListCubit>(context).priceList,
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
                  const Divider(
                    color: MakeMyTripColors.color30gray,
                    thickness: 1,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12, top: 6),
                    child: AllFiltersWidget(),
                  ),
                  Center(
                    child: FractionallySizedBox(
                        widthFactor: .9,
                        child: CommonPrimaryButton(
                            text: StringConstants.doneTxt,
                            onTap: () {
                              Navigator.pop(context);
                            })),
                  ),
                  12.verticalSpace
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
