part of 'homepage_cubit.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class GetData extends HomepageState {
  Stream<List<ImageModel>> GetList;

  GetData({required this.GetList});

  @override
  List<Object> get props => [];
}

class GetToursList extends HomepageState {
  Stream<List<ToursModel>> GettoursList;

  GetToursList({required this.GettoursList});

  @override
  List<Object> get props => [];
}
