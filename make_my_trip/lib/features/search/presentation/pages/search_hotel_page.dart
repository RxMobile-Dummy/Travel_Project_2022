import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.searchPageTitle,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: StringConstants.searchPageTitle,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )),
              onChanged: (String query) {
                print("1");
                context.read<SearchHotelCubit>().getSearchInputData(query);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: BlocBuilder<SearchHotelCubit, BaseState>(
                    builder: (context, state) {
                  print(state);
                  if (state is StateOnKnownToSuccess) {
                    searchModel = state.response as List<SearchHotelModel>;
                    print(searchModel?[0].description);
                    return ListView.builder(
                      itemCount: searchModel?.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: MakeMyTripColors.color50gray),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RoutesName.hotelList,
                                    arguments: {
                                      'city_name':
                                          searchModel?[index].description
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(searchModel?[index].description ?? ""),
                              ),
                            ));
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
