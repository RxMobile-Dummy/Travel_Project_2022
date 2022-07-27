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

import '../widgets/shimmer_effect_page.dart';

class WishListPage extends StatelessWidget {
  WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WishListCubit, BaseState>(
        builder: (context, state) {
          if (state is StateOnSuccess) {
            List<WishlistModel> wishlistModel = state.response;
            if (wishlistModel.isEmpty) {
              return CommonErrorWidget(
                  imagePath: ImagePath.noDataFoundImage,
                  title: StringConstants.noHotelInWishlist,
                  statusCode: "");
            }
            return CustomScrollView(
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
                  (BuildContext context, int index) {
                    return Hotal_Details(
                      wishlistModel: wishlistModel[index],
                    );
                  },
                  childCount: wishlistModel.length,
                )),
              ], //<Widget>[]
            );
          } else if (state is StateLoading) {
            return WishlistShimmer();
          } else if (state is StateErrorGeneral) {
            return CommonErrorWidget(
                imagePath: ImagePath.serverFailImage,
                title: StringConstants.serverFail,
                statusCode: "500");
          } else {
            return CommonErrorWidget(
                imagePath: ImagePath.noDataFoundImage,
                title: StringConstants.noHotelInWishlist,
                statusCode: "");
          }
        },
      ),
    );
  }
}
