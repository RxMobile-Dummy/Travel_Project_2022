import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_listing_repository.dart';

import '../../data/models/user_model.dart';

class UploadUserInfoUseCase {
  final HotelListingRepository hotelListingRepository;

  UploadUserInfoUseCase({required this.hotelListingRepository});

  void call(User user) {
    return hotelListingRepository.uploadUserInfo(user);
  }
}
