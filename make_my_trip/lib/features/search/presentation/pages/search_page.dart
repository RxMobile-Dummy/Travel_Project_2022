import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
import 'package:make_my_trip/utils/widgets/common_primary_button.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/theme/make_my_trip_colors.dart';
import '../cubit/search_cubit.dart';

class SearchHotelPage extends StatefulWidget {
  const SearchHotelPage({Key? key, required this.dio}) : super(key: key);
  final Dio dio;
  @override
  State<SearchHotelPage> createState() => _SearchHotelPageState();
}

class _SearchHotelPageState extends State<SearchHotelPage> {
  List<dynamic> _placesList = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void getSuggesion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAcmpKXz5KH8e7zmPkHNIIUuSBXI8qEBNs";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY';

    var response = await widget.dio.get(request);

    debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      setState(() {
        _placesList = response.data['predictions'];
      });
    } else {
      throw Exception('Failure');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, BaseState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => true);
        } else if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.wishList, (route) => true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.searchPageTitle,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                var searchState = context.read<SearchCubit>().state;
                if (searchState is Unauthenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.login, (route) => true);
                } else if (searchState is Authenticated) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.wishList, (route) => true);
                } else {
                  BlocProvider.of<SearchCubit>(context).goToWishlist();
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
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    // do something with query
                    getSuggesion(query);
                  });
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: MakeMyTripColors.color50gray),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RoutesName.hotelList, arguments: {
                                'city_name': _placesList[index]['description']
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_placesList[index]['description']),
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
