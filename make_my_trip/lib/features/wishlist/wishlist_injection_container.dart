import 'package:get_it/get_it.dart';
import 'package:make_my_trip/features/wishlist/data/data_sources/wishlist_remote_data_source.dart';
import 'package:make_my_trip/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:make_my_trip/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:make_my_trip/features/wishlist/domain/use_cases/wishlist_usecase.dart';
import 'package:make_my_trip/features/wishlist/presentation/cubit/wishlist_cubit.dart';

var wishListSl = GetIt.instance;

Future<void> init() async {
  //cubit
  wishListSl.registerFactory(() => WishListCubit(wishListSl()));

  //DataSource
  wishListSl.registerLazySingleton<WishListRemoteDataSource>(
      () => WishListRemoteDataSourceImpl(wishListSl()));

  //Repository
  wishListSl.registerLazySingleton<WishListRepository>(
      () => WishListRepositoryImpl(wishListSl()));

  //usecase
  wishListSl.registerLazySingleton(() => WishListUsecase(wishListSl()));

  // wishListSl.registerFactory(() => Dio());
}
