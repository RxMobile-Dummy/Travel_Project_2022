import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/gallery_page/presentation/pages/gallery_page.dart';
import 'package:make_my_trip/features/hotel_listing/hotel_list_injection_container.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';
import 'package:make_my_trip/features/intro/intro_injection_container.dart';
import 'package:make_my_trip/features/search/presentation/pages/search_page.dart';

import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/email_verification_page.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:make_my_trip/features/sign_up/signup_injection_container.dart';

import '../../features/home_page/presentation/manager/cubit/tab_bar_cubit.dart';
import '../../features/home_page/presentation/pages/homepage.dart';

import '../../features/hotel_detail/hotel_detail_injection_container.dart';
import '../../features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import '../../features/hotel_detail/presentation/pages/hotel_detail_page.dart';
import '../../features/intro/presentation/cubit/intro_cubit.dart';
import '../../features/intro/presentation/pages/intro_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

import 'package:make_my_trip/features/home_page/home_page_injection_container.dart';
import 'package:make_my_trip/features/home_page/presentation/manager/cubit/homepage_cubit.dart';

import 'package:make_my_trip/features/home_page/presentation/manager/cubit/tab_bar_cubit.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';

import 'package:make_my_trip/features/room_detail_page/room_detail_injection_container.dart';
import 'package:make_my_trip/features/splash/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/presentation/pages/intro_page.dart';
import '../../features/room_detail_page/presentation/manager/cubit/imageslider_cubit.dart';
import '../../features/room_detail_page/presentation/pages/roomdetail.dart';

import 'package:make_my_trip/features/review/presentation/cubit/publish_review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/pages/publish_review_page.dart';
import 'package:make_my_trip/features/review/presentation/pages/review_page.dart';
import 'package:make_my_trip/features/review/review_injection_container.dart';

import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/pages/room_categories_page.dart';
import 'package:make_my_trip/features/room_categories/room_categories_injection_container.dart';

import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/pages/login_page.dart';

import '../../features/login/presentation/widgets/resetPassword_widget.dart';
import '../../features/login/login_injection_container.dart';

import '../../features/wishlist/presentation/pages/wishlist_page.dart';

class Router {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) {
          return const SplashPage();
        });
      case RoutesName.onBoard:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => IntroSl<IntroCubit>(),
            child: IntroPage(),
          );
        });
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => loginSl<LoginCubit>(),
            child: LoginPage(),
          );
        });
      case RoutesName.signup:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => signUpSl<SignUpCubit>(),
              ),
              BlocProvider(
                create: (context) => loginSl<LoginCubit>(),
              ),
            ],
            child: SignUpPage(),
          );
        });
      case RoutesName.otp:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.verifyEmail:
        return MaterialPageRoute(builder: (_) {
          return EmailVerification();
        });
      case RoutesName.resetPassword:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => loginSl<LoginCubit>(),
            child: ResetPasswordPage(),
          );
        });
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: slHomePage<HomepageCubit>(),
              ),
              BlocProvider.value(value: TabBarCubit())
            ],
            child: HomePage(),
          );
        });
      case RoutesName.myTrips:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.wishList:
        return MaterialPageRoute(builder: (_) {
          return const WishListPage();
        });
      case RoutesName.profile:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.search:
        return MaterialPageRoute(builder: (_) {
          return SearchHotelPage(dio: Dio());
        });
      case RoutesName.hotelList:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => hotelListSl<HotelListCubit>(),
            child: HotelListPage(arg: arg),
          );
        });
      case RoutesName.hotelDetail:
        Map<String,dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => hotelDetailSl<HotelDetailCubit>()..getHotelDetailData(arg['hotel_id']),
            child: HotelDetailPage(),
          );
        });
      case RoutesName.roomCategory:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => roomCategorySl<RoomCategoryCubit>(),
            child: RoomCategoriesPage(),
          );
        });
      case RoutesName.roomDetail:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => roomDetailSl<ImagesliderCubit>(),
            child: RoomDetailsPage(),
          );
        });
      case RoutesName.reviewPage:
        Map<String,dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => reviewSl<ReviewCubit>()..getHotelReviewData(arg['hotel_id']),
            child: ReviewPage(arg:arg),
          );
        });
      case RoutesName.publishReviewPage:
        Map<String,dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) {
          return
            MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => reviewSl<PublishReviewCubit>() ),
    BlocProvider(create: (context) => reviewSl<ReviewCubit>() )
  ],
  child: PublishReviewPage(arg:arg),
);
           
        });
      case RoutesName.galleryPage:
        return MaterialPageRoute(builder: (_) {
          return GalleryPage();
        });
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
