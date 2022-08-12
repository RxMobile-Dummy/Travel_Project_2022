import '../../data/models/user_model.dart';

abstract class HotelListingRepository {
  void saveUserData();
  User fetchUserData();
  void uploadUserInfo(User user);
}
