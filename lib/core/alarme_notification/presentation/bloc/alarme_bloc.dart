import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grace_church/core/service_systeme/error/failure.dart';

import '../../domaine/entities/alarme_entite.dart';
import '../../domaine/entities/notification_programmee_entite.dart';
import '../../domaine/repositorie/alarme_repository.dart';
import '../../domaine/repositorie/permission_notification_repository.dart';
import '../../domaine/usecase/gerer_notifications_usecase.dart';
import '../../domaine/usecase/gerer_permission_notification_usecase.dart';
import '../../domaine/usecase/programmer_alarme_usecase.dart';

part 'alarme_event.dart';
part 'alarme_state.dart';

/// BLoC central de gestion des alarmes et notifications du module.
///
/// Interface unique entre les écrans et les usecases / contrats du domaine :
/// permissions, programmation, annulation, déclenchement, listing.
class AlarmeBloc extends Bloc<AlarmeEvent, AlarmeState> {
  AlarmeBloc(
    this._programmerAlarme,
    this._gererNotifications,
    this._gererPermissions,
    this._alarmeRepository,
  ) : super(const AlarmeInitial()) {
    on<DemandePermissionsAlarme>(_onPermission);
    on<VerifiePermissionsAlarme>(_onVerifiePermissions);
    on<ProgrammeAlarme>(_onProgramme);
    on<AnnuleAlarme>(_onAnnule);
    on<AfficheNotification>(_onAfficheNotification);
    on<ChargeAlarmes>(_onCharge);
  }

  final ProgrammerAlarmeUseCase _programmerAlarme;
  final GererNotificationsUseCase _gererNotifications;
  final GererPermissionsNotificationUseCase _gererPermissions;
  final AlarmeRepository _alarmeRepository;

  Future<void> _onPermission(
    DemandePermissionsAlarme event,
    Emitter<AlarmeState> emit,
  ) => _traiterPermissions(emit, demander: true);

  Future<void> _onVerifiePermissions(
    VerifiePermissionsAlarme event,
    Emitter<AlarmeState> emit,
  ) => _traiterPermissions(emit, demander: false);

  Future<void> _traiterPermissions(
    Emitter<AlarmeState> emit, {
    required bool demander,
  }) async {
    emit(const AlarmeChargement());
    final resultat = await _gererPermissions(
      GererPermissionsNotificationParams(demander: demander),
    );
    resultat.fold(
      (failure) {
        _journaliserEchec('permissions', failure);
        emit(AlarmeErreur(failure));
      },
      (permission) => emit(AlarmeChargee(permission: permission)),
    );
  }

  /// Journalise le message réel du [Failure] : sans cela, l'UI n'affiche que
  /// `Instance of 'Failure'` et le diagnostic est impossible.
  void _journaliserEchec(String operation, Failure failure) {
    debugPrint('❌ AlarmeBloc — $operation : ${failure.message}');
  }

  Future<void> _onProgramme(
    ProgrammeAlarme event,
    Emitter<AlarmeState> emit,
  ) async {
    emit(const AlarmeChargement());
    final resultat = await _programmerAlarme(
      ProgrammerAlarmeParams(event.alarme),
    );
    resultat.fold(
      (failure) {
        _journaliserEchec('programmation', failure);
        emit(AlarmeErreur(failure));
      },
      (_) => emit(
        AlarmeChargee(
          permission: state.permissionValue,
          messageInfo: 'Alarme ${event.alarme.id} programmée à ${event.alarme.dateHeure}',
        ),
      ),
    );
  }

  Future<void> _onAnnule(
    AnnuleAlarme event,
    Emitter<AlarmeState> emit,
  ) async {
    emit(const AlarmeChargement());
    final resultat = await _gererNotifications(
      GererNotificationsParams(
        typeOperation: OperationNotification.annuler,
        id: event.id,
      ),
    );
    resultat.fold(
      (failure) {
        _journaliserEchec('annulation', failure);
        emit(AlarmeErreur(failure));
      },
      (_) => emit(
        AlarmeChargee(
          permission: state.permissionValue,
          messageInfo: 'Alarme / notification ${event.id} annulée',
        ),
      ),
    );
  }

  Future<void> _onAfficheNotification(
    AfficheNotification event,
    Emitter<AlarmeState> emit,
  ) async {
    emit(const AlarmeChargement());
    final resultat = await _gererNotifications(
      GererNotificationsParams(
        typeOperation: OperationNotification.afficher,
        notification: event.notification,
      ),
    );
    resultat.fold(
      (failure) {
        _journaliserEchec('affichage notification', failure);
        emit(AlarmeErreur(failure));
      },
      (_) => emit(
        AlarmeChargee(
          permission: state.permissionValue,
          messageInfo: 'Notification affichée',
        ),
      ),
    );
  }

  Future<void> _onCharge(
    ChargeAlarmes event,
    Emitter<AlarmeState> emit,
  ) async {
    emit(const AlarmeChargement());

    final permission = await _gererPermissions(
      const GererPermissionsNotificationParams(),
    );
    final ids = await _alarmeRepository.alarmesEnAttente();

    final EtatPermission? permOut = permission.fold<EtatPermission?>(
      (failure) => null,
      (p) => p,
    );
    var enAttenteOut = ids.fold<List<int>?>(
      (failure) => null,
      (liste) => liste,
    );

    if (permOut == null || enAttenteOut == null) {
      emit(AlarmeErreur(const Failure('Impossible de charger les alarmes')));
      return;
    }

    emit(AlarmeChargee(permission: permOut, alarmesEnAttente: enAttenteOut));
  }
}
