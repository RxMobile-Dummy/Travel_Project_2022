part of 'homepage_cubit.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {

}

class GetData extends HomepageState {
  List<ImageModel> GetList;


  GetData({required this.GetList});

  @override
  List<Object> get props => [];
}

class GetToursList extends HomepageState {
  List<ToursModel> GetList;

  GetToursList({required this.GetList});

  @override
  List<Object> get props => [];
}
