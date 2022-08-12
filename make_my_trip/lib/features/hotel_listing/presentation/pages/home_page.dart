import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_listing_cubit.dart';
import 'package:make_my_trip/utils/widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final cubit = HotelListingCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HotelListingCubit, HotelListingState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is HotelListingLoading) {
              return const LoadingWidget();
            } else if (state is HotelListingLoaded) {
              return const Center(
                child: Text('HomePage'),
              );
            } else {
              return const Center(child: Text('Error while loading homepage.'));
            }
          }),
    );
  }
}
