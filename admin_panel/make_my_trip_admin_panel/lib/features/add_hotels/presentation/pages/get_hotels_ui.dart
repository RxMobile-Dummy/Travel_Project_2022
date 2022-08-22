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

  @override
  Widget build(BuildContext context) {
    print('get data call');
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddHotels()),
            ).then((value) {
              print('then');
              context.read<HotelCubit>().getHotels();
            });
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Padding(
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
            ),
            Expanded(
              flex: 9,
              child: BlocBuilder<HotelCubit, BaseState>(
                builder: (context, state) {
                  print("object ${state}");
                  // if (state is StateShowSearching) {
                  //   context.read<HotelCubit>().getHotels();
                  // }
                  if (state is StateOnSuccess) {
                    print(state.response);
                    List<HotelModels> hotel = state.response;
                    return ListView.builder(
                        itemCount: hotel.length,
                        itemBuilder: (context, index) {
                          return HotelListViewWidget(
                            hotel: hotel[index],
                            callback: (String id) async {
                              print('cubit press');
                              context.read<HotelCubit>().getPutHotel(id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddHotels()),
                              );
                              // BlocProvider.of<HotelCubit>(context).getHotels();
                            },
                          );
                        });
                  } else if (state is StateNoData) {
                    return const Center(child: Text("No data"));
                  } else {
                    print('Get data');
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ]),
        ));
  }
}
