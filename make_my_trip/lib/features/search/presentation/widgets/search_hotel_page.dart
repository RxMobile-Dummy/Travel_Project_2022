import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_state.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';
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
        automaticallyImplyLeading: true,
        title: Text(
          StringConstants.searchPageTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: StringConstants.searchPagetextfield,
                ),
                onChanged: (String query) {
                  print("search : " + query);

                  context.read<SearchHotelCubit>().getSearchInputData(query);
                },
              ),
              8.verticalSpace,
              BlocBuilder<SearchHotelCubit, SearchHotelState>(
                  builder: (context, state) {
                if (state is StateOnKnownToSuccessState) {
                  searchModel = state.response as List<SearchHotelModel>;
                  print("model${searchModel}");
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 1, color: MakeMyTripColors.color30gray)),
                    child: (searchModel!.length == 0)
                        ? const Text(
                            "No results found!!",
                            textAlign: TextAlign.center,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    await context
                                        .read<SearchHotelCubit>()
                                        .selectCityName(
                                            searchModel?[index].name ??
                                                "Ahmedabad",
                                            searchModel?[index].id ?? 1,
                                            searchModel?[index].type ??
                                                "Hotel");
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      (searchModel?[index].type == "hotel")
                                          ? const Icon(
                                              Icons.maps_home_work,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              Icons.place,
                                              color: Colors.grey,
                                            ),
                                      12.horizontalSpace,
                                      Flexible(
                                          child: Text(
                                              searchModel?[index].name ?? "")),
                                    ],
                                  ));
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
