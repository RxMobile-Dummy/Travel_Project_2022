import 'package:equatable/equatable.dart';
import 'package:make_my_trip_admin_panel/core/internet/internet_enum.dart';

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
  final bool? isMoreLoading;

  StateOnSuccess(this.response, {this.isMoreLoading});

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
  List<Object?> get props => [connectionType];
}

class InternetDisconnected extends BaseState {
  @override
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
