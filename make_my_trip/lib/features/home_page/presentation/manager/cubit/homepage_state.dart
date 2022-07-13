part of 'homepage_cubit.dart';

@immutable
abstract class HomepageState implements Equatable{}

class HomepageInitial extends HomepageState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();

}

class GetData extends HomepageState {
  List<ImageModel> GetList;


  GetData({required this.GetList});

  @override
  List<Object> get props => [GetList];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class GetToursList extends HomepageState {
  List<ToursModel> GetList;

  GetToursList({required this.GetList});

  @override
  List<Object> get props => [GetList];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
class StateOnSuccess<T> extends HomepageState{
  final T response;
  StateOnSuccess(this.response);
  @override
  List<Object?> get props => [response];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
