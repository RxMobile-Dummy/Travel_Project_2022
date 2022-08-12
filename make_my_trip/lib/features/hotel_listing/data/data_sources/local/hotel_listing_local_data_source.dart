import '../../models/user_model.dart';

abstract class HotelListingLocalDataSource {
  void saveUserData();
  User fetchUserData();
}
