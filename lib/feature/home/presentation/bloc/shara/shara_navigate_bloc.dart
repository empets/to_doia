import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/shara_navigation_usecase.dart';

abstract class SharaNavigationEvent extends Equatable {
  const SharaNavigationEvent();

  @override
  List<Object?> get props => [];
}

class SendGraceMessageEvent extends SharaNavigationEvent {
  const SendGraceMessageEvent(this.messages);

  final List<Map<String, String>> messages;

  @override
  List<Object?> get props => [messages];
}

abstract class SharaNavigationState extends Equatable {
  const SharaNavigationState();

  @override
  List<Object?> get props => [];
}

class SharaNavigationInitial extends SharaNavigationState {
  const SharaNavigationInitial();
}

class SharaNavigationLoading extends SharaNavigationState {
  const SharaNavigationLoading();
}

class SharaNavigationSuccess extends SharaNavigationState {
  const SharaNavigationSuccess(this.response);

  final GraceResponse response;

  @override
  List<Object?> get props => [response];
}

class SharaNavigationError extends SharaNavigationState {
  const SharaNavigationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class SharaNavigationBloc
    extends Bloc<SharaNavigationEvent, SharaNavigationState> {
  SharaNavigationBloc(this._useCase) : super(const SharaNavigationInitial()) {
    on<SendGraceMessageEvent>(_onSendGraceMessage);
  }

  final SharaNavigationUsecase _useCase;

  Future<void> _onSendGraceMessage(
    SendGraceMessageEvent event,
    Emitter<SharaNavigationState> emit,
  ) async {
    emit(const SharaNavigationLoading());

    final result = await _useCase(event.messages);

    result.fold(
      (failure) {
        emit(SharaNavigationError(failure.message));
      },
      (GraceResponse response) {
        emit(SharaNavigationSuccess(response));
      },
    );
  }
}
