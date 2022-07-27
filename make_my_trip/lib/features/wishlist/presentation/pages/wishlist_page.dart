import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/shimmer_cubit.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/details_card.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';

import 'shimmer_effect_page.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'My Wishlist';
    return MaterialApp(
      home: BlocProvider<ShimmerCubit>(
        create: (context) => ShimmerCubit(),
        child: Scaffold(body: BlocBuilder<ShimmerCubit, ShimmerState>(
          builder: (context, state) {
            if (state is ShimmerLoaded) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverLayoutBuilder(builder: (context, constraints) {
                    final scroll = constraints.scrollOffset > 145;
                    return SliverAppBar(
                      snap: false,
                      pinned: true,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Center(
                          child: Text(title,
                              style: TextStyle(
                                color: scroll
                                    ? MakeMyTripColors.colorBlack
                                    : MakeMyTripColors.colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ) //TextStyle
                              ),
                        ), //Text
                        background: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage(ImagePath.wishlistImage2),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3)),
                            ),
                          ),
                        ),
                      ),

                      expandedHeight: 230,
                      backgroundColor: MakeMyTripColors.colorWhite,
                      leading: IconButton(
                        color: scroll
                            ? MakeMyTripColors.color70gray
                            : MakeMyTripColors.colorWhite,
                        icon: const Icon(Icons.arrow_back_ios),
                        tooltip: 'back',
                        onPressed: () {},
                      ),
                      //IconButton
                      actions: <Widget>[
                        IconButton(
                          color: scroll
                              ? MakeMyTripColors.color70gray
                              : MakeMyTripColors.colorWhite,
                          icon: const Icon(
                            Icons.share,
                          ),
                          tooltip: 'Share Icon',
                          onPressed: () {},
                        ), //IconButton
                      ], //<Widget>[]
                    );
                  }), //SliverAppBar
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Hotal_Details();
                      },
                      childCount: 5,
                    ), //SliverChildBuildDelegate
                  ), //SliverList
                ], //<Widget>[]
              );
            } else {
              return WishlistShimmer();
            }
          },
        ) //CustonScrollView
            ),
      ), //Scaffold
      debugShowCheckedModeBanner: false,
      // Remove debug banner for proper
      // view of setting icon
    ); //MaterialApp
  }
}
