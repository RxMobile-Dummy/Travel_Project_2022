import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip_admin_panel/core/base/base_state.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/HotelModels.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/data/models/hotel_model.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/cubit/hotel_cubit.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/commonErrorWidget.dart';
import 'package:make_my_trip_admin_panel/features/add_hotels/presentation/widgets/hotel_listView.dart';
import 'package:make_my_trip_admin_panel/utils/constants/image_path.dart';
import 'package:make_my_trip_admin_panel/utils/constants/string_constants.dart';

class GetHotelUi extends StatelessWidget {
  GetHotelUi({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     BlocProvider.of<HotelCubit>(context).getHotels();
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: SafeArea(
        child: BlocBuilder<HotelCubit, BaseState>(
          builder: (context, state) {
            print("object");
            print(state);
            if(state is StateShowSearching){
              context.read<HotelCubit>().getHotels();
            }
            if (state is StateOnSuccess) {
               List<HotelModels> hotel = state.response;
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        context
                            .read<HotelCubit>()
                            .searchList(value.toString());
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
                      child: ListView.builder(
                          itemCount: hotel.length,
                          itemBuilder: (context, index) {
                            return HotelListViewWidget(
                                hotel: hotel[index]);
                          })),
                ],
              );
            } else if(state is StateNoData){
              return
                const Center(
                  child: Text("No data")
                );
            }
            else{
              print('Get data');
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
