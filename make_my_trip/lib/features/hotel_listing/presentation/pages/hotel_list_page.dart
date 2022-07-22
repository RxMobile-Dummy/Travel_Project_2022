import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_shimmer_page.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/widgets/hotel_list_widget.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import '../../../../core/navigation/route_info.dart';
import '../../hotel_list_injection_container.dart' as di;
import '../cubits/hotel_list_cubit.dart';
import '../cubits/hotel_list_state.dart';
import '../widgets/hotel_list_view_widget.dart';

class HotelListPage extends StatelessWidget {
  const HotelListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: MakeMyTripColors.color30gray,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          // const Spacer(),
                          Text(
                            StringConstants.hotelListPageTitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.unselectedLabelStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: MakeMyTripColors.accentColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.edit_note_rounded),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: MakeMyTripColors.color0gray,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    StringConstants.recommendedText,
                    style: AppTextStyles.unselectedLabelStyle,
                  ),
                ),
              ),
            ),
            BlocBuilder<HotelListCubit, HotelListState>(
              builder: (context, state) {
                if(state is GetData) {
                  List<HotelListModel> hotelListModel=state.GetList;
                  return Expanded(
                      child: ListView.builder(
                          itemCount: hotelListModel.length,
                          itemBuilder: (context, index) {
                            return HotelDetailCard(hotelListModel: hotelListModel[index],call: (id){
                              Navigator.pushNamed(context, RoutesName.hotelDetail,arguments: {"hotel_id" : id});
                            });
                          })
                  );
                }else{
                  return HotelListShimmer();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
