import 'package:make_my_trip/features/hotel_listing/data/data_sources/local/hotel_listing_local_data_source.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/user_model.dart';

class HotelListingLocalDataSourceImpl implements HotelListingLocalDataSource {
  @override
  User fetchUserData() {
    ///TO DO : local db getting data
    return User('name');
  }

  @override
  void saveUserData() {
    ///TO DO : local db saving data
  }
}
