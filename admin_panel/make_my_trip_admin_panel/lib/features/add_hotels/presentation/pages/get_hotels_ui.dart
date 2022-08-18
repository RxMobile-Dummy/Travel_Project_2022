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
  const GetHotelUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          BlocProvider.of<HotelCubit>(context).getHotels();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<HotelCubit, BaseState>(
          builder: (context, state) {
            if (state is StateOnSuccess) {
               List<HotelModels> hotel = state.response;
              return Expanded(
                  child: ListView.builder(
                      itemCount: hotel.length,
                      itemBuilder: (context, index) {
                        return HotelListViewWidget(
                            hotel: hotel![index]);
                      }));
            } else {
              return Text("Details");
            }
          },
        ),
      ),
    );
  }
}
