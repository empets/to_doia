part of 'alarme_bloc.dart';

/// ─────────────────────────── Events ───────────────────────────-

sealed class AlarmeEvent extends Equatable {
  const AlarmeEvent();

  @override
  List<Object?> get props => [];
}

/// Vérifie l'état des permissions (sans dialogue).
class VerifiePermissionsAlarme extends AlarmeEvent {
  const VerifiePermissionsAlarme();
}

/// Vérifie et demande les permissions (dialogue système).
class DemandePermissionsAlarme extends AlarmeEvent {
  const DemandePermissionsAlarme();
}

/// Programme (ou re-programme) une alarme.
class ProgrammeAlarme extends AlarmeEvent {
  const ProgrammeAlarme(this.alarme);

  final AlarmeEntite alarme;

  @override
  List<Object?> get props => [alarme];
}

/// Annule une alarme / notification par son identifiant.
class AnnuleAlarme extends AlarmeEvent {
  const AnnuleAlarme(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

/// Affiche immédiatement une notification locale.
class AfficheNotification extends AlarmeEvent {
  const AfficheNotification(this.notification);

  final NotificationProgrammeeEntite notification;

  @override
  List<Object?> get props => [notification];
}

/// Recharge permissions + alarmes en attente.
class ChargeAlarmes extends AlarmeEvent {
  const ChargeAlarmes();
}
