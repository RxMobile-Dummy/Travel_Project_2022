import 'package:equatable/equatable.dart';
import 'package:make_my_trip/features/home_page/data/models/ToursModel.dart';
import 'package:make_my_trip/features/home_page/data/models/ViewCouponModel.dart';
import 'package:make_my_trip/features/home_page/data/models/imageModel.dart';
import 'package:make_my_trip/features/setting_page/data/models/user_details_model.dart';

import '../internet/internet_enum.dart';

import '../../features/hotel_listing/data/models/hotel_list_model.dart';

abstract class BaseState extends Equatable {}

class Uninitialized extends BaseState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends BaseState {
  @override
  List<Object?> get props => [];
}

class Unauthenticated extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateInitial extends BaseState implements Equatable {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => null;
}

class StateLoading extends BaseState implements Equatable {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => null;
}

class StateNoData extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateShowSearching extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateSearchResult<T> extends BaseState {
  final T response;

  StateSearchResult(this.response);

  @override
  List<Object?> get props => [response];
}

class StateInternetError extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateError400 extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateErrorGeneralStateErrorServer extends BaseState {
  @override
  List<Object?> get props => [];
}

class StateOnSuccess<T> extends BaseState {
  final T response;

  StateOnSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class StateReorderSuccess<T> extends BaseState {
  final T response;
  final int? updatedIndex;

  StateReorderSuccess(this.response, {this.updatedIndex});

  @override
  List<Object?> get props => [response, updatedIndex];
}

class StateOnResponseSuccess<T> extends BaseState {
  final T response;

  StateOnResponseSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class StateOnKnownToSuccess<T> extends BaseState {
  final T response;

  StateOnKnownToSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ValidationError extends BaseState {
  final String errorMessage;

  ValidationError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class StateErrorGeneral extends BaseState {
  final String errorMessage;

  StateErrorGeneral(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class StateErrorListGeneral extends BaseState {
  final List<String> errorMessage;

  StateErrorListGeneral(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class StateDialogErrorGeneral extends BaseState {
  final String errorMessage;

  StateDialogErrorGeneral(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class InternetLoading extends BaseState {
  @override
  List<Object> get props => [];
}

class InternetConnected extends BaseState {
  final ConnectionType? connectionType;

  InternetConnected({required this.connectionType});

  @override
  // TODO: implement props
  List<Object?> get props => [connectionType];
}

class InternetDisconnected extends BaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StatePaginationSuccess extends BaseState implements Equatable {
  final List data;
  final bool isEndOfList;
  final bool isServerError;
  final bool isInternetError;

  StatePaginationSuccess(this.data, this.isEndOfList,
      {this.isServerError = false, this.isInternetError = false});

  StatePaginationSuccess copyWith({
    List? data,
    bool? isEndOfList,
    bool? isServerError,
    bool? isInternetError,
  }) =>
      StatePaginationSuccess(
        data ?? this.data,
        isEndOfList ?? this.isEndOfList,
        isServerError: isServerError ?? this.isServerError,
        isInternetError: isInternetError ?? this.isInternetError,
      );

  @override
  List<Object> get props => [data, isEndOfList, isServerError, isInternetError];

  @override
  bool? get stringify => null;
}

class StatePaginationInternetError<T> extends BaseState {
  final T response;

  StatePaginationInternetError(this.response);

  @override
  List<Object?> get props => [response];
}

class StatePaginationServerError<T> extends BaseState {
  final T response;

  StatePaginationServerError(this.response);

  @override
  List<Object?> get props => [response];
}

class FailErrorMessageState extends BaseState implements Equatable {
  final String errorMessage;

  FailErrorMessageState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => null;
}

class GettingStartedData extends BaseState implements Equatable {
  final bool? tourLoading;
  final bool? imageLoading;
  final bool? couponLoading;
  final List<ToursModel>? toursListValue;
  final List<HotelListModel>? imageListValue;
  final List<ViewCouponModel>? couponListvalue;

  GettingStartedData(
      {this.imageLoading,
      this.tourLoading,
        this.couponLoading,
      this.toursListValue,
      this.imageListValue,
      this.couponListvalue
      });

  GettingStartedData copyWith({
    bool? tourLoading,
    bool? imageLoading,
    bool? couponLoading,
    List<ToursModel>? toursListValue,
    List<HotelListModel>? imageListValue,
    List<ViewCouponModel>? couponListValue,
  }) =>
      GettingStartedData(
          tourLoading: tourLoading ?? this.tourLoading,
          imageLoading: imageLoading ?? this.imageLoading,
          couponLoading: couponLoading ?? this.couponLoading,
          toursListValue: toursListValue ?? this.toursListValue,
          imageListValue: imageListValue ?? this.imageListValue,
          couponListvalue: couponListValue ?? this.couponListvalue
      );

  @override
  List<Object?> get props =>
      [tourLoading, imageLoading, toursListValue, imageListValue, couponLoading, couponListvalue];
}

class SettingPageData {
  UserDetailsModel? userValue;
  String? imageValue;
  String? error;

  SettingPageData({this.userValue, this.imageValue, this.error});

  SettingPageData copyWith(
          {UserDetailsModel? userValue, String? imageValue, String? error}) =>
      SettingPageData(
          error: error ?? this.error,
          userValue: userValue ?? this.userValue,
          imageValue: imageValue ?? this.imageValue);
}
