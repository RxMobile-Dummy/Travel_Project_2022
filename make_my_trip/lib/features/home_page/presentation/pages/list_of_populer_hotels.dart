import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_shimmer_page.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/widgets/hotel_list_view_widget.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/navigation/route_info.dart';
import '../cubit/homepage_cubit.dart';

class ListOfPopulerHotels extends StatelessWidget {
  const ListOfPopulerHotels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular hotels"),
      ),
      body: SafeArea(
        child: BlocBuilder<HomepageCubit, BaseState>(
          builder: (context, state) {
            if (state is StateErrorGeneralStateErrorServer) {
              return CommonErrorWidget(
                onTap: () {
                  BlocProvider.of<HomepageCubit>(context).getPopularHotel();
                },
              );
            } else if (state is StateOnSuccess) {
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(state.response.length, (index) {
                      List<HotelListModel> imagelist = state.response!.toList();

                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: HotelListViewWidget(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RoutesName.searchHotel,
                                arguments: {
                                  "hotel_id": imagelist[index].hotelId,
                                  "hotel_name": imagelist[index].hotelName,
                                  "share_link": false
                                });
                          },
                          hotelListModel: imagelist[index],
                        ),
                      );
                    })),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 12),
                child: HotelListShimmer(),
              );
            }
          },
        ),
      ),
    );
  }
}
