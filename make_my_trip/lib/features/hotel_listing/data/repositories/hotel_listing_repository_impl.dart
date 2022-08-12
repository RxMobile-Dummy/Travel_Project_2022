import 'package:make_my_trip/features/hotel_listing/data/data_sources/local/hotel_listing_local_data_source.dart';
import 'package:make_my_trip/features/hotel_listing/data/data_sources/remote/hotel_listing_remote_data_source_impl.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/user_model.dart';
import 'package:make_my_trip/features/hotel_listing/domain/repositories/hotel_listing_repository.dart';

class HotelListingRepositoryImpl implements HotelListingRepository {
  final HotelListingLocalDataSource localDataSource;
  final HotelListingRemoteDataSourceImpl remoteDataSource;

  HotelListingRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  User fetchUserData() {
    return localDataSource.fetchUserData();
  }

  @override
  void saveUserData() {
    return localDataSource.saveUserData();
  }

  @override
  void uploadUserInfo(User user) {
    return remoteDataSource.uploadUserInfo(user);
  }
}
