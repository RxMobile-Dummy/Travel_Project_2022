import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../data/models/search_hotel_model.dart';
import '../cubit/search_hotel_cubit.dart';

class SearchHotelPage extends StatelessWidget {
  SearchHotelPage({Key? key}) : super(key: key);

  List<SearchHotelModel>? searchModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchHotelCubit, BaseState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => true,
              arguments: {"route_name": RoutesName.wishList});
        } else if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.wishList, (route) => true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            StringConstants.searchPageTitle,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                var searchState = context.read<SearchHotelCubit>().state;
                if (searchState is Unauthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => true,
                      arguments: {"route_name": RoutesName.wishList});
                } else if (searchState is Authenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.wishList, (route) => true);
                } else {
                  BlocProvider.of<SearchHotelCubit>(context).goToWishlist();
                }
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: StringConstants.searchPageTitle,
                ),
                onChanged: (String query) {
                  context.read<SearchHotelCubit>().getSearchInputData(query);
                },
              ),
              8.verticalSpace,
              BlocBuilder<SearchHotelCubit, BaseState>(
                  builder: (context, state) {
                if (state is StateOnKnownToSuccess) {
                  searchModel = state.response as List<SearchHotelModel>;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 1, color: MakeMyTripColors.color30gray)),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RoutesName.hotelList,
                                    arguments: {
                                      'city_name':
                                          searchModel?[index].description
                                    });
                              },
                              child:
                                  Text(searchModel?[index].description ?? ""));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                              height: 24,
                              thickness: 1,
                              color: MakeMyTripColors.color30gray);
                        },
                        itemCount: searchModel!.length),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
