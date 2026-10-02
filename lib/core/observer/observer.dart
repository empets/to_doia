import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';



class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('📥 Event ::-------->>> ${bloc.runtimeType} => $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('🔁 Transition :: -------->>>  ${bloc.runtimeType} => $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('❌ Error in ::-------->> ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }
}
