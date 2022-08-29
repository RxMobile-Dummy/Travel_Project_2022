import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_shimmer_page.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';
import '../../data/models/hotel_list_model.dart';
import '../cubits/hotel_list_cubit.dart';
import '../widgets/filter_all_filter_widget.dart';
import '../widgets/hotel_list_view_widget.dart';
import 'filter_list.dart';

class HotelListPage extends StatelessWidget {
  HotelListPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.read<HotelListCubit>.call().setUpScrollController(_scrollController,
        arg['cin'], arg['cout'], arg['no_of_room'], arg['id'], arg['type']);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, RoutesName.filter,
                    arguments: {"context": context});
                BlocProvider.of<HotelListCubit>(context).getHotelListApi(
                    arg['cin'],
                    arg['cout'],
                    arg['no_of_room'],
                    arg['id'],
                    arg['type']);
              },
              child: const Icon(
                FontAwesomeIcons.sliders,
                color: MakeMyTripColors.color90gray,
              ),
            ),
          ),
        ],
        // elevation: 0,
        title: Text(
          arg['city_name'],
          maxLines: 1,
          style: AppTextStyles.unselectedLabelStyle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HotelListCubit, BaseState>(
          builder: (context, state) {
            if (state is StateErrorGeneralStateErrorServer) {
              return CommonErrorWidget(
                onTap: () {
                  BlocProvider.of<HotelListCubit>(context).getHotelListApi(
                      arg['cin'],
                      arg['cout'],
                      arg['no_of_room'],
                      arg['id'],
                      arg['type']);
                },
              );
            } else if (state is StateInternetError) {
              return CommonErrorWidget(
                title: StringConstants.internetErrorTitle,
                subTitle: StringConstants.internetErrorSubTitle,
                onTap: () {
                  BlocProvider.of<HotelListCubit>(context).getHotelListApi(
                      arg['cin'],
                      arg['cout'],
                      arg['no_of_room'],
                      arg['id'],
                      arg['type']);
                },
              );
            } else if (state is StateOnSuccess) {
              List<HotelListModel> listOfHotel = state.response;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.verticalSpace,
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: AllFiltersWidget(),
                  ),
                  (listOfHotel.isEmpty)
                      ? const Expanded(
                          child: CommonErrorWidget(
                              imagePath: ImagePath.noBookingPage,
                              subTitle:
                                  "Sorry there are no results match for these filters",
                              title: "No hotel found"),
                        )
                      : Expanded(
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: state.isMoreLoading
                                  ? listOfHotel.length + 1
                                  : listOfHotel.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (index != listOfHotel.length)
                                      HotelListViewWidget(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RoutesName.hotelDetail,
                                                arguments: {
                                                  "hotel_id":
                                                      listOfHotel[index].id,
                                                  "share_link": false
                                                });
                                          },
                                          hotelListModel:
                                              state.response[index]),
                                    if (index == listOfHotel.length)
                                      const CircularProgressIndicator()
                                  ],
                                );
                              }),
                        )
                ],
              );
            } else {
              return const HotelListShimmer();
            }
          },
        ),
      ),
    );
  }
}
