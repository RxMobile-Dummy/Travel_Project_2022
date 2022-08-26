import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/features/wishlist/data/model/wishlist_model.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:make_my_trip/features/wishlist/presentation/widgets/details_card.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';

import '../../wishlist_injection_container.dart';
import '../widgets/shimmer_effect_page.dart';

class WishListPage extends StatelessWidget {
  WishListPage({Key? key}) : super(key: key);
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.read<WishListCubit>.call().setUpScrollController(_scrollController);
    return Scaffold(
      body: BlocBuilder<WishListCubit, BaseState>(
        builder: (context, state) {
          if (state is StateErrorGeneralStateErrorServer) {
            return CommonErrorWidget(
              onTap: () {
                BlocProvider.of<WishListCubit>(context).getWishListCubitData();
              },
            );
          } else if (state is StateInternetError) {
            return CommonErrorWidget(
              title: "No Connection",
              subTitle: "Please check your internet connection and try again",
              onTap: () {
                BlocProvider.of<WishListCubit>(context).getWishListCubitData();
              },
            );
          } else if (state is StateOnSuccess) {
            List<WishlistModel> wishlistModel = state.response;
            if (wishlistModel.isEmpty) {
              return const CommonErrorWidget(
                  imagePath: ImagePath.noBookingPage,
                  subTitle:
                      "You don't have any hotel at this moment in your whishlist",
                  title: "No hotels found");
            }
            return CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverLayoutBuilder(builder: (context, constraints) {
                  final scroll = constraints.scrollOffset > 145;
                  return SliverAppBar(
                    snap: false,
                    pinned: true,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(StringConstants.wishlist,
                          style: TextStyle(
                            color: scroll
                                ? MakeMyTripColors.colorBlack
                                : MakeMyTripColors.colorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ) //TextStyle
                          ), //Text
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                wishlistModel[wishlistModel.length - 1]
                                    .wishListImage![0]
                                    .imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: MakeMyTripColors.colorBlack
                                    .withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ),
                    expandedHeight: 230,
                    backgroundColor: MakeMyTripColors.colorWhite,
                  );
                }), //SliverAppBar
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        if (index != wishlistModel.length)
                          HotalDetails(
                            wishlistModel: wishlistModel[index],
                          ),
                        if (index == wishlistModel.length)
                          const CircularProgressIndicator()
                      ],
                    );
                  },
                  childCount: state.isMoreLoading
                      ? wishlistModel.length + 1
                      : wishlistModel.length,
                )),
              ], //<Widget>[]
            );
          } else {
            return WishlistShimmer();
          }
        },
      ),
    );
  }
}
