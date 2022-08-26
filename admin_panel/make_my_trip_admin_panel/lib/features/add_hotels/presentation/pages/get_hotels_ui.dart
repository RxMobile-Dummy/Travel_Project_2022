import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/add_hotels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/commonErrorWidget.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/hotel_listView.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class GetHotelUi extends StatelessWidget {
  GetHotelUi({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size);
    context.read<HotelCubit>.call().setUpScrollController(_scrollController);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddHotels()),
            ).then((value) {
              context.read<HotelCubit>().getHotels();
            });
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  context.read<HotelCubit>().searchList(value.toString());
                },
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HotelCubit, BaseState>(
                builder: (context, state) {
                  // if (state is StateShowSearching) {
                  //   context.read<HotelCubit>().getHotels();
                  // }
                  if (state is StateOnSuccess) {
                    List<HotelModels> hotel = state.response;
                    if (size.width > 1200) {
                      return GridView.builder(
                            itemCount: hotel.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  if (index != hotel.length)
                                    HotelListViewWidget(
                                      hotel: hotel[index],
                                      callback: (String id) async {
                                        context
                                            .read<HotelCubit>()
                                            .getPutHotel(id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddHotels()),
                                        );
                                        // BlocProvider.of<HotelCubit>(context).getHotels();
                                      },
                                    ),
                                  if (index == hotel.length)
                                    const CircularProgressIndicator()
                                ],
                              );
                            });

                    } else if (size.width > 500) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.isMoreLoading
                              ? hotel.length + 1
                              : hotel.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index != hotel.length)
                                  HotelListViewWidget(
                                    hotel: hotel[index],
                                    callback: (String id) async {
                                      context
                                          .read<HotelCubit>()
                                          .getPutHotel(id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddHotels()),
                                      );
                                      // BlocProvider.of<HotelCubit>(context).getHotels();
                                    },
                                  ),
                                if (index == hotel.length)
                                  const CircularProgressIndicator()
                              ],
                            );
                          });
                    } else{
                      return ListView.builder(
                          controller: _scrollController,
                          itemCount: state.isMoreLoading
                              ? hotel.length + 1
                              : hotel.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                if (index != hotel.length)
                                  HotelListViewWidget(
                                    hotel: hotel[index],
                                    callback: (String id) async {

                                      context
                                          .read<HotelCubit>()
                                          .getPutHotel(id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddHotels()),
                                      );
                                      // BlocProvider.of<HotelCubit>(context).getHotels();
                                    },
                                  ),
                                if (index == hotel.length)
                                  const CircularProgressIndicator()
                              ],
                            );
                          });
                    }

                  } else {
                    return const Center(child: Text("No data"));
                  }
                  // else {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                },
              ),
            )
          ]),
        ));
  }
}
