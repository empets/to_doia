part of 'alarme_bloc.dart';

/// ─────────────────────────── States ───────────────────────────-

sealed class AlarmeState extends Equatable {
  const AlarmeState({this.permission, this.alarmesEnAttente = const [], this.messageInfo});

  final EtatPermission? permission;
  final List<int> alarmesEnAttente;
  final String? messageInfo;

  /// Accès pratique pour le BLoC quand il enrichit l'état courant.
  EtatPermission? get permissionValue => permission;

  @override
  List<Object?> get props => [permission, alarmesEnAttente, messageInfo];
}

class AlarmeInitial extends AlarmeState {
  const AlarmeInitial();
}

class AlarmeChargement extends AlarmeState {
  const AlarmeChargement();
}

class AlarmeChargee extends AlarmeState {
  const AlarmeChargee({
    super.permission,
    super.alarmesEnAttente,
    super.messageInfo,
  });
}

class AlarmeErreur extends AlarmeState {
  const AlarmeErreur(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
