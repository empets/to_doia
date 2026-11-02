import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/alarme_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/entities/notification_programmee_entite.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/permission_notification_repository.dart';
import 'package:grace_church/core/alarme_notification/domaine/usecase/gerer_notifications_usecase.dart';
import 'package:grace_church/core/alarme_notification/domaine/usecase/gerer_permission_notification_usecase.dart';
import 'package:grace_church/core/alarme_notification/domaine/usecase/programmer_alarme_usecase.dart';
import 'package:grace_church/core/alarme_notification/domaine/repositorie/alarme_repository.dart';
import 'package:grace_church/core/alarme_notification/presentation/bloc/alarme_bloc.dart';
import 'package:grace_church/core/alarme_notification/service/alarme_notification_service.dart';
import 'package:grace_church/core/injetction/injection_container.dart';

/// ⚠️ Écran TEMPORAIRE de simulation du module alarme/notification.
/// Sert à valider sur l'appareil :
///  1. programmation ponctuelle (alarme dans 1 min),
///  2. notification locale immédiate,
///  3. alarme répétée hebdo (matchDateTimeComponents),
///  4. permissions (vérifier / demander),
///  5. app fermée → notification sonne → tap → cold start.
class SimulationAlarmePage extends StatelessWidget {
  const SimulationAlarmePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlarmeBloc(
        getIt<ProgrammerAlarmeUseCase>(),
        getIt<GererNotificationsUseCase>(),
        getIt<GererPermissionsNotificationUseCase>(),
        getIt<AlarmeRepository>(),
      )..add(const VerifiePermissionsAlarme()),
      child: const _SimulationView(),
    );
  }
}

class _SimulationView extends StatelessWidget {
  const _SimulationView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AlarmeBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Simulation — Alarmes & Notifications')),
      body: BlocBuilder<AlarmeBloc, AlarmeState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── État courant ──
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is AlarmeErreur)
                        Card(
                          color: Colors.red.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              '❌ Erreur : ${state.failure.message}',
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                          ),
                        ),
                      if (state is AlarmeErreur) const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Permissions notifications'),
                        value: state.permission?.notifications ?? false,
                        onChanged: (_) =>
                            bloc.add(const DemandePermissionsAlarme()),
                      ),
                      SwitchListTile(
                        title: const Text('Alarmes exactes'),
                        value: state.permission?.alarmesExactes ?? false,
                        onChanged: (_) =>
                            bloc.add(const DemandePermissionsAlarme()),
                      ),
                      if (state.messageInfo != null)
                        Text(
                          state.messageInfo!,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      Text(
                        'Alarmes en attente sur l\'OS : ${state.alarmesEnAttente.join(', ').isEmpty ? '(aucune)' : state.alarmesEnAttente.join(', ')}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Tests ──
              ElevatedButton(
                onPressed: () => bloc.add(const DemandePermissionsAlarme()),
                child: const Text('1. Demander les permissions'),
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () => bloc.add(
                  ProgrammeAlarme(
                    AlarmeEntite(
                      id: 8888,
                      titre: '⏰ Simulation',
                      corps: 'Alarme ponctuelle — l\'app peut être fermée !',
                      dateHeure: DateTime.now().add(const Duration(minutes: 1)),
                      payload: const {'route': '/simulation'},
                    ),
                  ),
                ),
                child: const Text('2. Programmer une alarme dans 1 minute'),
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () => bloc.add(
                  AfficheNotification(
                    NotificationProgrammeeEntite(
                      id: 7777,
                      titre: '🔔 Notification locale',
                      corps: 'Affichée tout de suite (app ouverte)',
                      dateHeure: DateTime.now(),
                    ),
                  ),
                ),
                child: const Text('3. Notification immédiate'),
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () {
                  var lundi = DateTime.now();
                  while (lundi.weekday != DateTime.monday ||
                      !lundi.isAfter(DateTime.now())) {
                    lundi = lundi.add(const Duration(days: 1));
                  }
                  lundi = DateTime(lundi.year, lundi.month, lundi.day, 8, 19);
                  bloc.add(
                    ProgrammeAlarme(
                      AlarmeEntite(
                        id: 9999,
                        titre: '📅 Alarme répétée',
                        corps: 'Chaque lundi à 7h54',
                        dateHeure: lundi,
                        joursDeRepetition: const {1: true},
                      ),
                    ),
                  );
                },
                child: const Text('4. Alarme répétée — chaque lundi 7h54'),
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () => bloc.add(const AnnuleAlarme(8888)),
                child: const Text('5. Annuler l\'alarme de test (8888)'),
              ),
              const SizedBox(height: 16),

              OutlinedButton(
                onPressed: () => bloc.add(const ChargeAlarmes()),
                child: const Text('6. Rafraîchir les alarmes en attente'),
              ),
              const SizedBox(height: 24),

              // ── Cold start: affichage du payload de lancement ──
              Builder(
                builder: (context) {
                  final payload =
                      getIt<AlarmeNotificationService>().payloadDeLancement;
                  return Card(
                    color: payload != null ? Colors.green.shade50 : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        payload == null
                            ? 'App ouverte normalement (pas via notification).'
                            : '🚀 App lancée PAR une notification !\npayload: $payload',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              const Text(
                '🧪 Test complet :\n'
                '1) Touche « 2 » puis FERME l\'app (swipe)\n'
                '2) Attends 1 min → la notification sonne\n'
                '3) Touche la notification → l\'app démarre\n'
                '4) Ouvre cette page : la carte verte affiche le payload',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.verified_user),
        label: const Text('Permissions'),
        onPressed: () {
          // Ouvre les réglages système si besoin (refus définitif).
          getIt<PermissionNotificationRepository>().ouvrirReglages();
        },
      ),
    );
  }
}
