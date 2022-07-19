import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///use this common bloc for listing state changes
class CustomBlocListener<B extends Bloc<dynamic, S>, S> {
  final Widget child;

  final B bloc;

  BlocWidgetListener<S> listener;

  final BlocListenerCondition<S> condition;

  CustomBlocListener({
    required Key key,
    required this.listener,
    required this.bloc,
    required this.condition,
    required this.child,
  }) : assert(listener != null);

  BlocListener getBlocListener() {
    return BlocListener<B, S>(
      bloc: bloc,
      listenWhen: condition,
      child: child,
      listener: (context, state) async {
        ///To DO : replace this state with Authenticated, UnAuthenticated whatever you want.

      },
    );
  }
}
