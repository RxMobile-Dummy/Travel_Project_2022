import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/navigation/route_info.dart';
import 'package:make_my_trip/features/booking/booking_injection_container.dart';
import 'package:make_my_trip/features/booking/presentation/cubit/book_cubit.dart';
import 'package:make_my_trip/features/booking/presentation/pages/booking_page.dart';
import 'package:make_my_trip/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:make_my_trip/features/gallery_page/presentation/cubit/gallery_cubit.dart';
import 'package:make_my_trip/features/gallery_page/presentation/pages/gallery_page.dart';
import 'package:make_my_trip/features/hotel_listing/hotel_list_injection_container.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/cubits/hotel_list_cubit.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_page.dart';
import 'package:make_my_trip/features/intro/intro_injection_container.dart';
import 'package:make_my_trip/features/search/presentation/cubit/search_hotel_cubit.dart';
import 'package:make_my_trip/features/search/search_hotel_injection_container.dart';
import 'package:make_my_trip/features/room_categories/presentation/cubit/select_room_count.dart';
import 'package:make_my_trip/features/room_detail_page/room_detail_injection_container.dart';
import 'package:make_my_trip/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/email_verification_page.dart';
import 'package:make_my_trip/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:make_my_trip/features/sign_up/signup_injection_container.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:make_my_trip/features/wishlist/wishlist_injection_container.dart';
import 'package:make_my_trip/features/user_history/presentation/pages/user_history_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/home_page/presentation/cubit/homepage_cubit.dart';
import '../../features/home_page/presentation/cubit/tab_bar_cubit.dart';
import '../../features/home_page/presentation/pages/homepage.dart';
import '../../features/hotel_detail/hotel_detail_injection_container.dart';
import '../../features/hotel_detail/presentation/cubit/hotel_detail_cubit.dart';
import '../../features/hotel_detail/presentation/pages/hotel_detail_page.dart';
import '../../features/intro/presentation/cubit/intro_cubit.dart';
import '../../features/intro/presentation/pages/intro_page.dart';
import '../../features/search/presentation/pages/search_hotel_page.dart';
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
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/login/presentation/widgets/resetPassword_widget.dart';
import '../../features/login/login_injection_container.dart';
import '../../features/wishlist/presentation/pages/wishlist_page.dart';

class Router {
  var Cubit1 = reviewSl<ReviewCubit>();

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
            create: (context) => loginSl<LoginCubit>(),
            child: LoginPage(arg: arg),
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
                value: slHomePage<HomepageCubit>()
                  ..getImagesApi()
                  ..getToursApi(),
              ),
              BlocProvider.value(value: slHomePage<TabBarCubit>())
            ],
            child: HomePage(),
          );
        });
      case RoutesName.myTrips:
        return MaterialPageRoute(builder: (_) {
          return UserHistoryPage();
        });
      case RoutesName.wishList:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) =>
                wishListSl<WishListCubit>()..getWishListCubitData(),
            child: WishListPage(),
          );
        });
      case RoutesName.profile:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
      case RoutesName.search:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => searchHotelSl<SearchHotelCubit>(),
            child: SearchHotelPage(),
          );
        });
      case RoutesName.hotelList:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => hotelListSl<HotelListCubit>()
              ..getHotelListApi(arg['city_name']),
            child: HotelListPage(arg: arg),
          );
        });
      case RoutesName.hotelDetail:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => hotelDetailSl<HotelDetailCubit>()
              ..getHotelDetailData(arg['hotel_id']),
            child: HotelDetailPage(),
          );
        });
      case RoutesName.calendar:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => CalenderCubit(),
            child: CalendarPage(arg: arg),
          );
        });
      case RoutesName.roomCategory:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => roomCategorySl<RoomCategoryCubit>()
                  ..getData(arg['hotel_id'], arg['cin'], arg['cout']),
              ),
              BlocProvider(
                create: (context) => roomCategorySl<SelectRoomCountCubit>(),
              ),
            ],
            child: RoomCategoriesPage(
              arg: arg,
            ),
          );
        });
      case RoutesName.roomDetail:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
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
          );
        });
      case RoutesName.reviewPage:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: Cubit1..getHotelReviewData(arg['hotel_id']),
            child: ReviewPage(arg: arg),
          );
        });
      case RoutesName.publishReviewPage:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: Cubit1,
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
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => bookingSl<BookingCubit>(),
            child: BookingPage(arg: arg),
          );
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
