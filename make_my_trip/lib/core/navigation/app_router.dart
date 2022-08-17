import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/booking/booking_injection_container.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/payment_integeration_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/pages/booking_page.dart';
import 'package:make_my_trip/features/gallery_page/presentation/cubit/gallery_cubit.dart';
import 'package:make_my_trip/features/gallery_page/presentation/pages/gallery_page.dart';
import 'package:make_my_trip/features/hotel_listing/hotel_list_injection_container.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/filter_list.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';
import 'package:make_my_trip/features/intro/intro_injection_container.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_cubit.dart';
import 'package:make_my_trip/features/search/search_hotel_injection_container.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/select_room_count.dart';
import 'package:make_my_trip/features/room_detail_page/room_detail_injection_container.dart';
import 'package:make_my_trip/features/setting_page/presentation/cubit/setting_page_cubit.dart';
import 'package:make_my_trip/features/setting_page/presentation/pages/settings_page.dart';
import 'package:make_my_trip/features/setting_page/setting_page_injection_container.dart';
import 'package:make_my_trip/features/user/presentation/pages/sign_up_page.dart';
import 'package:make_my_trip/features/user/presentation/cubit/user_cubit.dart';
import 'package:make_my_trip/features/user/presentation/pages/login_page.dart';
import 'package:make_my_trip/features/user/presentation/widgets/resetPassword_widget.dart';
import 'package:make_my_trip/features/user/user_injection_container.dart';
import 'package:make_my_trip/features/user_history/presentation/cubit/user_history_cubit.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:make_my_trip/features/wishlist/wishlist_injection_container.dart';
import 'package:make_my_trip/features/user_history/presentation/pages/user_history_page.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/home_page/presentation/cubit/homepage_cubit.dart';
import '../../features/home_page/presentation/cubit/tab_bar_cubit.dart';
import '../../features/home_page/presentation/pages/homepage.dart';

import '../../features/hotel_detail/hotel_detail_injection_container.dart';
import '../../features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import '../../features/hotel_detail/presentation/pages/hotel_detail_page.dart';
import '../../features/intro/presentation/cubit/intro_cubit.dart';
import '../../features/intro/presentation/pages/intro_page.dart';
import '../../features/room_categories/data/model/room_data_booking_post_model.dart';
import '../../features/search/presentation/pages/search_hotel_home_page.dart';
import '../../features/search/presentation/widgets/search_hotel_page.dart';
import '../../features/setting_page/presentation/pages/customerSupport_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

import 'package:make_my_trip/features/home_page/home_page_injection_container.dart';
import 'package:make_my_trip/features/home_page/presentation/pages/homepage.dart';
import 'package:make_my_trip/features/splash/presentation/pages/splash_page.dart';
import 'package:make_my_trip/features/intro/presentation/cubit/intro_cubit.dart';
import 'package:make_my_trip/features/intro/presentation/pages/intro_page.dart';
import '../../features/room_detail_page/presentation/manager/cubit/imageslider_cubit.dart';
import '../../features/room_detail_page/presentation/pages/room_detail.dart';

import 'package:make_my_trip/features/review/presentation/cubit/publish_review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/cubit/review_cubit.dart';
import 'package:make_my_trip/features/review/presentation/pages/publish_review_page.dart';
import 'package:make_my_trip/features/review/presentation/pages/review_page.dart';
import 'package:make_my_trip/features/review/review_injection_container.dart';

import 'package:make_my_trip/features/room_categories/presentation/cubit/room_category_cubit.dart';
import 'package:make_my_trip/features/room_categories/presentation/pages/room_categories_page.dart';
import 'package:make_my_trip/features/room_categories/room_categories_injection_container.dart';

import '../../features/user_history/user_history_injection_container.dart';
import '../../features/wishlist/presentation/pages/wishlist_page.dart';
import '../../features/search/search_hotel_injection_container.dart';

class Router {
  final searchHotelCubit = SearchHotelCubit(searchHotelSl(), searchHotelSl());

  Route<dynamic> generateRoutes(RouteSettings settings) {
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
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => userSl<UserCubit>(),
            child: LoginPage(arg: arg),
          );
        });
      case RoutesName.signup:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => userSl<UserCubit>(),
              ),
            ],
            child: SignUpPage(),
          );
        });
      case RoutesName.resetPassword:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<UserCubit>(arg['context']),
            child: ResetPasswordPage(),
          );
        });
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                  value: slHomePage<HomepageCubit>()
                    ..getToursApi()
                    ..getImagesApi()
                    ..getCouponsApi()
              ),
              BlocProvider.value(value: slHomePage<TabBarCubit>())
            ],
            child: HomePage(),
          );
        });
      case RoutesName.myTrips:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                historyListSl<UserHistoryCubit>()..getUserHistoryData(),
            child: UserHistoryPage(),
          );
        });
      case RoutesName.wishList:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                wishListSl<WishListCubit>()..getWishListCubitData(),
            child: WishListPage(),
          );
        });
      case RoutesName.searchHotel:
        return PageTransition(
          type: PageTransitionType.scale,
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
          child: BlocProvider.value(
            value: searchHotelCubit,
            child: SearchHotel(),
          ),
        );
      case RoutesName.search:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<SearchHotelCubit>(arg["context"]),
            child: SearchHotelPage(),
          );
        });
      case RoutesName.hotelList:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500),
          child: BlocProvider(
            create: (context) => hotelListSl<HotelListCubit>()
              ..getHotelListApi(arg['cin'], arg['cout'], arg['no_of_room'],
                  arg['id'], arg['type']),
            child: HotelListPage(arg: arg),
          ),
        );
      case RoutesName.filter:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<HotelListCubit>(arg["context"]),
            child: FilterList(arg: arg),
          );
        });
      case RoutesName.hotelDetail:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return hotelDetailSl<HotelDetailCubit>()
                    ..getHotelDetailData(arg['hotel_id']);
                },
              ),
              BlocProvider.value(
                value: searchHotelCubit,
              ),
            ],
            child: HotelDetailPage(),
          ),
        );

      case RoutesName.roomCategory:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 500),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => roomCategorySl<RoomCategoryCubit>()
                  ..getData(arg['hotel_id'], arg['cin'], arg['cout'],
                      arg['noofrooms']),
              ),
              BlocProvider(
                create: (context) => roomCategorySl<SelectRoomCountCubit>(),
              ),
            ],
            child: RoomCategoriesPage(
              arg: arg,
            ),
          ),
        );

      case RoutesName.roomDetail:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => roomDetailSl<ImagesliderCubit>()
                  ..getRoomData(arg['hotel_id'], arg['room_id']),
              ),
              BlocProvider.value(
                value: BlocProvider.of<SelectRoomCountCubit>(arg["context"]),
              ),
              BlocProvider.value(
                value: roomDetailSl<RoomCategoryCubit>(),
              )
            ],
            child: RoomDetailsPage(
              arg: arg,
            ),
          ),
        );

      case RoutesName.reviewPage:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                reviewSl<ReviewCubit>()..getHotelReviewData(arg['hotel_id']),
            child: ReviewPage(arg: arg),
          );
        });
      case RoutesName.publishReviewPage:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => reviewSl<PublishReviewCubit>()),
              BlocProvider(create: (context) => reviewSl<ReviewCubit>())
            ],
            child: PublishReviewPage(arg: arg),
          );
        });
      case RoutesName.galleryPage:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                GalleryCubit()..convertImageData(arg['image_list']),
            child: GalleryPage(
              arg: arg,
            ),
          );
        });
      case RoutesName.bookingPage:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        var detail = arg["model"] as RoomDataPostModel;
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => bookingSl<PaymentCubit>()
                  ..bookingConfirm(detail.hotelId!, detail.checkinDate!,
                      detail.checkoutDate!, detail.roomId!, detail.adults!),
              ),
            ],
            child: BookingPage(
              arg: arg,
            ),
          );
        });
      case RoutesName.settingPage:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: slSettingPage<SettingPageCubit>(),
            child: const SettingsPage(),
          );
        });
      case RoutesName.help:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<SettingPageCubit>(
            create: (context) => slSettingPage<SettingPageCubit>(),
            child: const CustomerSupportPage(),
          );
        });
      case RoutesName.errorPage:
        return MaterialPageRoute(builder: (_) {
          return const CommonErrorWidget(
              imagePath: ImagePath.confirmSuccess,
              title: StringConstants.futureTxt,
              statusCode: "");
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
