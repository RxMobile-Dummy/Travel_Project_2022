import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/core/navigation/route_info.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/pages/add_hotels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/hotel_listView.dart';
import 'package:make_my_trip_admin_panel/utils/widgets/common_error_widget.dart';

class GetHotelUi extends StatelessWidget {
  GetHotelUi({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<HotelModels> hotel=[];
    bool? isMoreLoading = false;
    context.read<HotelCubit>().setUpScrollController(_scrollController);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamedAndRemoveUntil(
                context, RoutesName.addHotel, (route) => false);
          },
          child: const Icon(Icons.add),
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
                  if(state is StateLoading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (state is StateOnSuccess) {
                   hotel = state.response;
                   isMoreLoading = state.isMoreLoading;

                  }else if (State is StateNoData) {
                    return const Center(child: Text("No data"));
                  } else if (State is StateErrorGeneral) {
                    return const CommonErrorWidget();
                  }
                  if (size.width >= 1200) {
                    print("1200");
                      return GridView.builder(
                          itemCount: hotel.length,
                          controller:_scrollController ,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    },
                                  ),
                                if (index == hotel.length)
                                  const CircularProgressIndicator()
                              ],
                            );
                          });
                    } else if (size.width > 500 && size.width<1200) {
                      return GridView.builder(
                        controller: _scrollController,
                          itemCount: isMoreLoading!
                              ? hotel.length + 1
                              : hotel.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                            builder: (context) =>
                                                const AddHotels()),
                                      );
                                    },
                                  ),
                                if (index == hotel.length)
                                  const CircularProgressIndicator()
                              ],
                            );
                          });
                    } else {
                      return ListView.builder(
                          controller: _scrollController,
                          itemCount: isMoreLoading!
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
                                            builder: (context) => const AddHotels()),
                                      );
                                    },
                                  ),
                                if (index == hotel.length)
                                  const CircularProgressIndicator()
                              ],
                            );
                          });
                    }

                },
              ),
            )
          ]),
        ));
  }
}
