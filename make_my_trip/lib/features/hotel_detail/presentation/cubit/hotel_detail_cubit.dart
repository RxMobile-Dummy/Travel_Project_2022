import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/hotel_detail/data/model/hotel_detail_model.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/hotel_detail_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/islike_delete_usecase.dart';
import 'package:make_my_trip/features/hotel_detail/domain/use_cases/islike_post_usecase.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/base/base_state.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';

class HotelDetailCubit extends Cubit<BaseState> {
  HotelDetailCubit(this.hotelDetailUseCase, this.isLikePostUseCase,
      this.isLikeDeleteUseCase, this.isAnonymousUser)
      : super(StateInitial());

  bool islike = false;
  final HotelDetailUseCase hotelDetailUseCase;
  final IsLikePostUseCase isLikePostUseCase;
  final IsLikeDeleteUseCase isLikeDeleteUseCase;
  final IsAnonymousUser isAnonymousUser;

  onLikeTap(bool isLiked, int? hotelId) async {
    emit(Uninitialized());
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {}, (success) {
      if (success) {
        emit(Unauthenticated());
      } else {
        if (isLiked == true && hotelId != null) {
          isLikeDeleteUseCase.call(IsLikeDeleteParams(index: hotelId));
        } else if (isLiked == false && hotelId != null) {
          isLikePostUseCase.call(IsLikePostParams(index: hotelId));
        }
        emit(StateSearchResult<bool>(!isLiked));
      }
    });
  }

  onReadMoreTap(bool isReadMore) {
    emit(StateOnSuccess<bool>(!isReadMore));
  }

  onSwipeIndicator(index) {
    emit(StateOnResponseSuccess<int>(index));
  }

  getHotelDetailData(int data) async {
    emit(StateLoading());
    final res = await hotelDetailUseCase.call(HotelDetailParams(index: data));
    res.fold((l) => emit(StateErrorGeneral("errorMessage")),
        (r) => emit(StateOnKnownToSuccess<HotelDetailModel>(r)));
  }

  Future<Uri> createDynamicLink(int hotelId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://travelproject22.page.link',
      link: Uri.parse(
          'https://travelproject22.page.link.com/hotel?paramId=$hotelId'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.make_my_trip',
        minimumVersion: 1,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.worldtour.makeMyTrip',
        minimumVersion: '1',
      ),
    );
    var dynamicUrl =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortLink = dynamicUrl.shortUrl;
    return shortLink;
  }

  Future<void> onShare(
      HotelDetailModel hotelDetailModel, BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    Uri subjectLink = await createDynamicLink(hotelDetailModel.id!);
    await Share.share(
      "Check Out This amazing Hotel on Travelsy! \n ${hotelDetailModel.hotelName!} \n ${subjectLink.toString()}",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
