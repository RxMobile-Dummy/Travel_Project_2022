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

import '../../../../core/navigation/route_info.dart';
import '../../../setting_page/presentation/pages/settings_page.dart';
import '../../wishlist_injection_container.dart';
import '../widgets/shimmer_effect_page.dart';

class WishListPage extends StatelessWidget {
  Map<String, dynamic>? arg;
  WishListPage({Key? key,this.arg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        var argument = arg!["route_name"];
        if (argument == RoutesName.search ||
        argument == RoutesName.settingPage){
          return navigateToPrevious(context,argument);
        }
        else {
          return navigateToHomePage(context);
        }
      },
      child: Scaffold(
        body: BlocBuilder<WishListCubit, BaseState>(
          builder: (context, state) {
            if (state is StateOnSuccess) {
              List<WishlistModel> wishlistModel = state.response;
              if (wishlistModel.isEmpty) {
                return CommonErrorWidget(
                    imagePath: ImagePath.noDataFoundImage,
                    title: StringConstants.noHotelInWishlist,
                    statusCode: StringConstants.emptyString);
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverLayoutBuilder(builder: (context, constraints) {
                    final scroll = constraints.scrollOffset > 145;
                    return SliverAppBar(
                      snap: false,
                      pinned: true,
                      floating: false,
                      iconTheme: scroll?const IconThemeData(color: MakeMyTripColors.colorBlack):const IconThemeData(color: MakeMyTripColors.colorWhite),
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
                                  color: Colors.black.withOpacity(0.3)),
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
                      return HotalDetails(
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
                  statusCode: StringConstants.emptyString);
            } else {
              return CommonErrorWidget(
                  imagePath: ImagePath.noDataFoundImage,
                  title: StringConstants.noHotelInWishlist,
                  statusCode: StringConstants.emptyString);
            }
          },
        ),
      ),
    );
  }


}
navigateToPrevious(BuildContext context, arg) {
  Navigator.of(context).pop(arg);
}
