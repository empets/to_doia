
// lib/screens/voice_listening_screen.dart
import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grace_church/core/alert/app_alerte.dart';
import 'package:grace_church/core/ia_analyse/ai_analyzing_screen.dart';
import 'package:grace_church/core/injetction/injection_container.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_usecase.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/create_task_bloc.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/event/create_tast_event.dart';
import 'package:grace_church/feature/home/presentation/bloc/create_task.dart/state/create_tast_state.dart';
import 'package:grace_church/feature/home/presentation/bloc/voice_task.dart';

class VoiceListeningScreen extends StatefulWidget {
  const VoiceListeningScreen({super.key});

  @override
  State<VoiceListeningScreen> createState() => _VoiceListeningScreenState();
}

class _VoiceListeningScreenState extends State<VoiceListeningScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static const _primary = Color(0xFF6366F1);
  static const _grey = Color(0xFF6B7280);

  late final AnimationController _pulse;
  late final AnimationController _wave;

  final List<double> _waveHeights = List.generate(9, (_) => 8);
  int _tick = 0;

  // Lecteur audio
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  final List<StreamSubscription<dynamic>> _subs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Démarré / arrêté selon l'état (voir BlocListener)
    _wave = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    )..addListener(_updateWave);

    _subs.addAll([
      _player.onPlayerStateChanged.listen((s) {
        if (!mounted) return;
        setState(() => _isPlaying = s == PlayerState.playing);
      }),
      _player.onPositionChanged.listen((p) {
        if (!mounted) return;
        setState(() => _position = p);
      }),
      _player.onDurationChanged.listen((d) {
        if (!mounted) return;
        setState(() => _duration = d);
      }),
      _player.onPlayerComplete.listen((_) {
        if (!mounted) return;
        setState(() => _position = Duration.zero);
      }),
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VoiceTaskCubit>().start();
    });
  }

  // Mise en pause automatique quand l'app passe en arrière-plan
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.paused &&
        state != AppLifecycleState.hidden) {
      return;
    }
    _player.pause();
    final cubit = context.read<VoiceTaskCubit>();
    if (cubit.state is VoiceRecording) cubit.pause();
  }

  void _updateWave() {
    _tick++;
    for (int i = 0; i < _waveHeights.length; i++) {
      _waveHeights[i] = 8 + (sin((_tick * 0.3 + i) * 0.9).abs() * 22);
    }
  }

  Future<void> _togglePlay(String path) async {
    try {
      if (_isPlaying) {
        await _player.pause();
      } else if (_player.state == PlayerState.paused) {
        await _player.resume();
      } else {
        await _player.play(DeviceFileSource(path));
      }
    } catch (_) {
      if (mounted) {
        AppAlert.showError(context, "Impossible de lire l'enregistrement");
      }
    }
  }

  Future<void> _restart() async {
    await _player.stop();
    if (!mounted) return;
    await context.read<VoiceTaskCubit>().restart();
  }

  /// Retour à l'état initial de la page (nouvel enregistrement vierge).
  /// Utilisé quand la requête échoue ou que le vocal est inexploitable.
  Future<void> _resetPage() async {
    await _player.stop();
    if (!mounted) return;
    setState(() {
      _position = Duration.zero;
      _duration = Duration.zero;
    });
    await context.read<VoiceTaskCubit>().retry();
  }

  Future<void> _send() async {
    await _player.stop();
    if (!mounted) return;
    await context.read<VoiceTaskCubit>().send();
  }

  Future<void> _cancel() async {
    await _player.stop();

    if (!mounted) return;
    await context.read<VoiceTaskCubit>().cancel();
    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final s in _subs) {
      s.cancel();
    }
    _player.dispose();

    _pulse.dispose();
    _wave.removeListener(_updateWave);
    _wave.dispose();

    super.dispose();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _primary, width: 2),
        ),
        child: Icon(icon, color: _primary, size: 28),
      ),
    );
  }

  Widget _pillButton(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: _primary,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FormTastBloc(createTaskUseCase: getIt<CreateTaskUseCase>()),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          final s = context.read<VoiceTaskCubit>().state;
          if (s is VoiceLoading || s is VoiceSuccess) return;
          _cancel();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<VoiceTaskCubit, VoiceTaskState>(
              listener: (context, state) {
                // Ondes : animées uniquement pendant l'enregistrement
                if (state is VoiceRecording) {
                  if (!_wave.isAnimating) _wave.repeat(reverse: true);
                  setState(() {
                    _position = Duration.zero;
                    _duration = Duration.zero;
                  });
                } else {
                  _wave.stop();
                }

                if (state is VoiceSuccess) {
                  if (state.result.title.isNotEmpty &&
                      state.result.content.isNotEmpty
                  //&&
                  // state.result.date.isNotEmpty &&
                  // state.result.time.isNotEmpty
                  ) {
                    final form = context.read<FormTastBloc>();
                    form.add(CreateTaskEvent.changeTitle(state.result.title));
                    form.add(
                      CreateTaskEvent.changeContent(state.result.content),
                    );
                    form.add(CreateTaskEvent.changeDate("2026-10-20"));
                    form.add(CreateTaskEvent.changeTime("12:00"));
                    form.add(CreateTaskEvent.changeRecurring(false));
                    form.add(CreateTaskEvent.changeStatus(state.result.status));
                    form.add(CreateTaskEvent.changeTaskId('sdddd'));
                    // Le submit part APRÈS le remplissage du formulaire
                    form.add(CreateTaskEvent.submit());
                  } else {
                    _resetPage();
                    return AppAlert.showInfo(
                      context,
                      'Veuillez reprendre le vocal, car nous n’avons pas pu détecter la date ni l’heure.',
                    );
                  }
                }

                if (state is VoiceError) {
                  return AppAlert.showError(context, state.message);
                }
              },
            ),
            BlocListener<FormTastBloc, CreateTastState>(
              // Uniquement quand le statut change (évite les boucles)
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, stateForm) {
                if (stateForm.status.isSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AIAnalyzingScreen(
                        task: TaskResponse(
                          title: stateForm.title.value,
                          date: stateForm.date.value,
                          time: stateForm.time.value,
                          recurring: stateForm.recurring,
                          content: stateForm.content.value,
                          status: 'AVENIR',
                        ),
                      ),
                    ),
                  );
                }

                if (stateForm.status.isFailure) {
                  // Retour à l'état initial de la page
                  _resetPage();
                  return AppAlert.showError(
                    context,
                    "Une erreur est survenue, veuillez réessayer.",
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<VoiceTaskCubit, VoiceTaskState>(
            builder: (context, state) {
              final bool isRecording = state is VoiceRecording;
              final bool isPaused = state is VoicePaused;
              final bool isStopped = state is VoiceStopped;
              // VoiceSuccess = soumission du formulaire en cours
              final bool isLoading =
                  state is VoiceLoading || state is VoiceSuccess;
              final bool isError = state is VoiceError;

              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLoading
                                ? 'Analyse en cours...'
                                : isPaused
                                ? 'En pause'
                                : isStopped
                                ? 'Écoutez votre enregistrement'
                                : isError
                                ? 'Enregistrement impossible'
                                : 'Je vous écoute...',
                            style: GoogleFonts.roboto(
                              color: _grey,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 44.h),

                          // Microphone animé
                          AnimatedBuilder(
                            animation: _pulse,
                            builder: (_, _) {
                              return SizedBox(
                                width: 200,
                                height: 200,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ...List.generate(
                                      3,
                                      (i) => Container(
                                        width:
                                            100 +
                                            (i + 1) * 30 +
                                            _pulse.value * 10,
                                        height:
                                            100 +
                                            (i + 1) * 30 +
                                            _pulse.value * 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _primary.withOpacity(
                                            0.1 - i * 0.025,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF818CF8),
                                            Color(0xFF6366F1),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _primary.withOpacity(
                                              0.5 + _pulse.value * 0.1,
                                            ),
                                            blurRadius: 36 + _pulse.value * 10,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isPaused || isError
                                            ? Icons.mic_off_rounded
                                            : Icons.mic_rounded,
                                        color: Colors.white,
                                        size: 37.h,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 40.h),

                          // Ondes audio (rebuild limité à cette zone)
                          SizedBox(
                            height: 48.h,
                            child: AnimatedBuilder(
                              animation: _wave,
                              builder: (_, _) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: _waveHeights
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 80,
                                        ),
                                        width: 5,
                                        height: isRecording ? entry.value : 8,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color.lerp(
                                            const Color(0xFF818CF8),
                                            _primary,
                                            entry.value / 30,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Chronomètre
                          if (isRecording || isPaused)
                            AnimatedBuilder(
                              animation: _wave,
                              builder: (context, _) => Text(
                                _fmt(context.read<VoiceTaskCubit>().elapsed),
                                style: GoogleFonts.roboto(
                                  color: _grey,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                            )
                          else
                            SizedBox(height: 18.sp * 1.2),

                          const SizedBox(height: 24),

                          // Statut de l'enregistrement
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isRecording
                                      ? const Color(0xFFEF4444)
                                      : isPaused
                                      ? const Color(0xFFF59E0B)
                                      : _grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                isLoading
                                    ? 'Traitement en cours...'
                                    : isRecording
                                    ? 'Enregistrement en cours...'
                                    : isPaused
                                    ? 'Enregistrement en pause'
                                    : isStopped
                                    ? 'Enregistrement terminé'
                                    : 'Enregistrement arrêté',
                                style: GoogleFonts.roboto(
                                  color: _grey,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          // Pause / Reprendre + Arrêter
                          if (isRecording || isPaused)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _circleButton(
                                  isRecording
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  () {
                                    final cubit = context
                                        .read<VoiceTaskCubit>();
                                    isRecording
                                        ? cubit.pause()
                                        : cubit.resume();
                                  },
                                ),
                                const SizedBox(width: 20),
                                _pillButton(
                                  Icons.stop_rounded,
                                  'Arrêter',
                                  () => context.read<VoiceTaskCubit>().stop(),
                                ),
                              ],
                            ),

                          // Écoute / Envoi / Recommencer
                          if (state is VoiceStopped)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      Slider(
                                        activeColor: _primary,
                                        inactiveColor: const Color(0xFFE5E7EB),
                                        max: max(
                                          1,
                                          (_duration > Duration.zero
                                                  ? _duration
                                                  : state.duration)
                                              .inMilliseconds
                                              .toDouble(),
                                        ),
                                        value: min(
                                          _position.inMilliseconds.toDouble(),
                                          max(
                                            1,
                                            (_duration > Duration.zero
                                                    ? _duration
                                                    : state.duration)
                                                .inMilliseconds
                                                .toDouble(),
                                          ),
                                        ),
                                        onChanged: (v) => _player.seek(
                                          Duration(milliseconds: v.toInt()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _fmt(_position),
                                              style: GoogleFonts.roboto(
                                                color: _grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Text(
                                              _fmt(
                                                _duration > Duration.zero
                                                    ? _duration
                                                    : state.duration,
                                              ),
                                              style: GoogleFonts.roboto(
                                                color: _grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _circleButton(
                                      _isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      () => _togglePlay(state.path),
                                    ),
                                    const SizedBox(width: 20),
                                    _pillButton(
                                      Icons.send_rounded,
                                      'Envoyer',
                                      _send,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                TextButton.icon(
                                  onPressed: _restart,
                                  icon: const Icon(
                                    Icons.refresh_rounded,
                                    color: _grey,
                                    size: 18,
                                  ),
                                  label: Text(
                                    'Recommencer',
                                    style: GoogleFonts.roboto(
                                      color: _grey,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          // Réessayer après une erreur (permission, trop court...)
                          if (isError)
                            _pillButton(
                              Icons.mic_rounded,
                              'Réessayer',
                              () => context.read<VoiceTaskCubit>().retry(),
                            ),

                          // Loader pendant l'envoi
                          if (isLoading)
                            const SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: _primary,
                              ),
                            ),

                          const SizedBox(height: 14),

                          // Annuler (supprime l'enregistrement)
                          if (!isLoading)
                            TextButton(
                              onPressed: _cancel,
                              child: Text(
                                'Annuler',
                                style: GoogleFonts.roboto(
                                  color: _grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
