import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grace_church/core/constante/constantes.dart';
import 'package:grace_church/core/extention/app_extention.dart';
import 'package:grace_church/core/service_systeme/error/failure.dart';
import 'package:grace_church/core/voice/voice_listening.dart';
import 'package:grace_church/feature/home/data/service/remote/groq_remote_data_soucre.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/shara_navigation_usecase.dart';
import 'package:grace_church/feature/home/overview.dart';
import 'package:grace_church/feature/home/presentation/bloc/shara/shara_navigate_bloc.dart';
import 'package:grace_church/feature/home/presentation/page/home_screen.dart';
import 'package:grace_church/feature/setting/setting_screen.dart';
import 'package:grace_church/feature/taches/presentation/pages/tasks_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_to_text.dart';

// TODO: adapte ce chemin vers ton GroqRemoteDataSource

enum VoiceState { off, idle, recording, thinking, speaking }

class _Msg {
  _Msg(this.text, {required this.fromUser});
  final String text;
  final bool fromUser;
}

class VoiceChatPage extends StatefulWidget {
  const VoiceChatPage({super.key});

  @override
  State<VoiceChatPage> createState() => _VoiceChatPageState();
}

class _VoiceChatPageState extends State<VoiceChatPage> {
  // --- config ---
  static const _wakeWords = ['grace', 'grâce'];
  static const _goodbyes = [
    'au revoir',
    'à bientôt',
    'merci grace',
    "c'est tout",
  ];

  // --- services ---
  final _groq = GetIt.I<GroqRemoteDataSource>();
  final _stt = SpeechToText();
  final _rec = AudioRecorder();
  final _tts = FlutterTts();

  // --- état ---
  final _msgs = <_Msg>[];
  final _history = <Map<String, String>>[];
  final _scroll = ScrollController();
  VoiceState _state = VoiceState.off;
  bool _ready = false;
  bool _active = false; // écoute du mot d'activation
  bool _busy = false; // conversation en cours
  bool _inConversation = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _active = false;
    _inConversation = false;
    _stt.cancel();
    _tts.stop();
    _rec.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _set(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  void _setState(VoiceState s) => _set(() => _state = s);

  // ---------------------------------------------------------------------------
  // Init
  // ---------------------------------------------------------------------------
  Future<void> _init() async {
    final micOk = await _rec.hasPermission();
    final sttOk = await _stt.initialize(
      onStatus: (s) {
        if (_active && !_busy && (s == 'done' || s == 'notListening')) {
          _listenWake();
        }
      },
      onError: (e) => log('STT erreur : ${e.errorMsg}'),
    );

    await _tts.setLanguage('fr-FR');
    final voices = await _tts.getVoices as List?;
    final fr = voices
        ?.cast<Map>()
        .where((v) => (v['locale'] as String).toLowerCase().startsWith('fr'))
        .toList();
    if (fr != null && fr.isNotEmpty) {
      await _tts.setVoice({
        'name': fr.first['name'],
        'locale': fr.first['locale'],
      });
    }
    await _tts.setVolume(1.0);
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    await _tts.awaitSpeakCompletion(true);
    await _tts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playAndRecord,
      [
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
      ],
      IosTextToSpeechAudioMode.defaultMode,
    );
    _tts.setErrorHandler((m) => log('TTS erreur : $m'));

    _set(() => _ready = micOk && sttOk);
    if (!_ready) log('Micro ou reconnaissance vocale indisponible');
  }

  // ---------------------------------------------------------------------------
  // Contrôle
  // ---------------------------------------------------------------------------
  Future<void> _onOrbTap() async {
    if (!_ready) return;
    if (!_active) {
      _active = true;
      _setState(VoiceState.idle);
      await _listenWake();
    } else if (_state == VoiceState.idle) {
      await _startConversation(); // démarrage manuel sans dire le nom
    } else {
      await _stopAll();
    }
  }

  Future<void> _stopAll() async {
    _active = false;
    _inConversation = false;
    await _stt.stop();
    await _tts.stop();
    if (await _rec.isRecording()) await _rec.stop();
    _busy = false;
    _setState(VoiceState.off);
  }

  // ---------------------------------------------------------------------------
  // 1. Mot d'activation
  // ---------------------------------------------------------------------------
  Future<void> _listenWake() async {
    if (!_active || _busy || _stt.isListening) return;
    _setState(VoiceState.idle);
    await _stt.listen(
      localeId: 'fr_FR',
      listenFor: const Duration(minutes: 1),
      pauseFor: const Duration(seconds: 10),
      listenOptions: SpeechListenOptions(partialResults: true),
      onResult: (r) {
        final heard = r.recognizedWords.toLowerCase();
        if (!_busy && _wakeWords.any(heard.contains)) _startConversation();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 2. Conversation continue
  // ---------------------------------------------------------------------------
  Future<void> _startConversation() async {
    if (_busy) return;
    _busy = true;
    _inConversation = true;
    await _stt.stop();
    _history.clear();
    await _say('Oui ?');

    try {
      while (_inConversation && _active) {
        // J'écoute
        _setState(VoiceState.recording);
        final path = await _record();
        if (path == null) break; // silence prolongé -> fin de session

        // Je réfléchis
        _setState(VoiceState.thinking);
        final question = (await _groq.transcribe(path)).trim();
        if (question.isEmpty) continue;
        _addMsg(question, fromUser: true);

        if (_goodbyes.any(question.toLowerCase().contains)) {
          _setState(VoiceState.speaking);
          await _say('À bientôt !');
          break;
        }

        // _history.add({'role': 'user', 'content': question});
        // final answer = await _groq.chat(_takeLast(_history, 12));
        // _history.add({'role': 'assistant', 'content': answer});
        // _addMsg(answer, fromUser: false);

        // // Je réponds (interruptible)
        // _setState(VoiceState.speaking);
        // await _sayInterruptible(answer);
      }
    } catch (e, st) {
      log('Erreur pipeline : $e', stackTrace: st);
      await _say("Désolée, une erreur s'est produite.");
    } finally {
      _inConversation = false;
      _busy = false;
      if (_active) {
        _listenWake();
      } else {
        _setState(VoiceState.off);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Audio
  // ---------------------------------------------------------------------------
  Future<void> _say(String text) async {
    await _tts.stop();
    await Future.delayed(const Duration(milliseconds: 300));
    final r = await _tts.speak(text);
    log('speak -> $r');
  }

  /// Parle tout en surveillant le micro : si tu parles, Grace s'arrête.
  Future<void> _sayInterruptible(String text) async {
    final dir = await getTemporaryDirectory();
    await _rec.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        echoCancel: true,
        noiseSuppress: true,
      ),
      path: '${dir.path}/barge.m4a',
    );

    var loud = 0;
    final watcher = Timer.periodic(const Duration(milliseconds: 150), (
      _,
    ) async {
      final amp = await _rec.getAmplitude();
      loud = amp.current > -20
          ? loud + 1
          : 0; // monte vers -12 si faux déclenchements
      if (loud >= 3) await _tts.stop();
    });

    await _say(text);
    watcher.cancel();
    if (await _rec.isRecording()) await _rec.stop();
  }

  /// Enregistre jusqu'au silence. Renvoie null si rien n'a été dit.
  Future<String?> _record() async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/cmd.m4a';
    await _rec.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        echoCancel: true,
        noiseSuppress: true,
      ),
      path: path,
    );

    final done = Completer<void>();
    var spoke = false, silentMs = 0, totalMs = 0;

    final timer = Timer.periodic(const Duration(milliseconds: 200), (t) async {
      final amp = await _rec.getAmplitude();
      totalMs += 200;
      if (amp.current > -30) {
        spoke = true;
        silentMs = 0;
      } else {
        silentMs += 200;
      }
      if ((spoke && silentMs >= 1200) ||
          (!spoke && totalMs >= 8000) ||
          totalMs >= 30000 ||
          !_inConversation) {
        t.cancel();
        if (!done.isCompleted) done.complete();
      }
    });

    await done.future;
    timer.cancel();
    final file = await _rec.stop();
    return spoke ? file : null;
  }

  // ---------------------------------------------------------------------------
  // Utils
  // ---------------------------------------------------------------------------
  List<Map<String, String>> _takeLast(List<Map<String, String>> l, int n) =>
      l.length <= n ? List.of(l) : l.sublist(l.length - n);

  void _addMsg(String text, {required bool fromUser}) {
    _set(() => _msgs.add(_Msg(text, fromUser: fromUser)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------
  String get _label => switch (_state) {
    VoiceState.off => _ready ? 'Appuie pour activer' : 'Initialisation…',
    VoiceState.idle => 'Dis « Grace » ou appuie pour parler',
    VoiceState.recording => 'Je t’écoute…',
    VoiceState.thinking => 'Je réfléchis…',
    VoiceState.speaking => 'Grace parle…',
  };

  Color get _color => switch (_state) {
    VoiceState.off => Colors.grey,
    VoiceState.idle => Colors.indigo,
    VoiceState.recording => Colors.redAccent,
    VoiceState.thinking => Colors.amber,
    VoiceState.speaking => Colors.teal,
  };

  double get _size => switch (_state) {
    VoiceState.recording => 110,
    VoiceState.speaking => 105,
    VoiceState.thinking => 90,
    _ => 80,
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grace'),
        actions: [
          if (_msgs.isNotEmpty)
            IconButton(
              tooltip: 'Effacer',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _set(() {
                _msgs.clear();
                _history.clear();
              }),
            ),
        ],
      ),
      body: Column(
        children: [
          // --- Transcript ---
          Expanded(
            child: _msgs.isEmpty
                ? Center(
                    child: Text(
                      'Dis « Grace » pour commencer',
                      style: TextStyle(color: cs.outline),
                    ),
                  )
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.all(16),
                    itemCount: _msgs.length,
                    itemBuilder: (_, i) {
                      final m = _msgs[i];
                      return Align(
                        alignment: m.fromUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.78,
                          ),
                          decoration: BoxDecoration(
                            color: m.fromUser
                                ? cs.primaryContainer
                                : cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(m.text),
                        ),
                      );
                    },
                  ),
          ),

          // --- Orbe + statut ---
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120,
                    child: Center(
                      child: GestureDetector(
                        onTap: _onOrbTap,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: _size,
                          height: _size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _color,
                            boxShadow: [
                              BoxShadow(
                                color: _color.withValues(alpha: 0.45),
                                blurRadius: _state == VoiceState.off ? 0 : 28,
                                spreadRadius: _state == VoiceState.off ? 0 : 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            _state == VoiceState.off
                                ? Icons.mic_off
                                : _state == VoiceState.speaking
                                ? Icons.graphic_eq
                                : Icons.mic,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_label, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VoiceWaveform extends StatefulWidget {
  const VoiceWaveform({
    super.key,
    this.isRecording = false,
    this.isThinking = false,
    this.amplitude = 0,
    this.height = 160,
    this.barCount = 51,
  });

  final bool isRecording;
  final bool isThinking;
  final double amplitude;
  final double height;
  final int barCount;

  @override
  State<VoiceWaveform> createState() => _VoiceWaveformState();
}

class _VoiceWaveformState extends State<VoiceWaveform>
    with TickerProviderStateMixin {
  late final AnimationController _motion;
  late final AnimationController _transition;

  late Animation<double> _amplitudeAnimation;
  double _currentAmplitude = 0;

  @override
  void initState() {
    super.initState();

    _motion = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();

    _transition = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    _amplitudeAnimation = AlwaysStoppedAnimation(
      widget.amplitude.clamp(0.0, 1.0),
    );
    _currentAmplitude = widget.amplitude.clamp(0.0, 1.0);
  }

  @override
  void didUpdateWidget(covariant VoiceWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);

    final target = widget.isRecording ? widget.amplitude.clamp(0.0, 1.0) : 0.0;

    if (target != oldWidget.amplitude ||
        widget.isRecording != oldWidget.isRecording) {
      _currentAmplitude = _amplitudeAnimation.value;

      _amplitudeAnimation = Tween<double>(begin: _currentAmplitude, end: target)
          .animate(
            CurvedAnimation(parent: _transition, curve: Curves.easeOutCubic),
          );

      _transition.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _motion.dispose();
    _transition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: AnimatedBuilder(
          animation: Listenable.merge([_motion, _transition]),
          builder: (context, _) {
            return CustomPaint(
              painter: _FluidWavePainter(
                progress: _motion.value,
                amplitude: _amplitudeAnimation.value,
                recording: widget.isRecording,
                thinking: widget.isThinking,
                barCount: widget.barCount,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FluidWavePainter extends CustomPainter {
  _FluidWavePainter({
    required this.progress,
    required this.amplitude,
    required this.recording,
    required this.thinking,
    required this.barCount,
  });

  final double progress;
  final double amplitude;
  final bool recording;
  final bool thinking;
  final int barCount;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0 || barCount < 2) {
      return;
    }

    final centerY = size.height / 2;
    final spacing = size.width / (barCount + 1);
    final maxHeight = size.height * 0.43;
    final phase = progress * 2 * math.pi;

    final shader = const LinearGradient(
      colors: [
        Color(0xFF526BFF),
        Color(0xFF00D9FF),
        Color(0xFF7965FF),
        Color(0xFFED59F5),
        Color(0xFF7965FF),
      ],
    ).createShader(Offset.zero & size);

    final glowPaint = Paint()
      ..shader = shader
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(2.5, spacing * 0.72)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final barPaint = Paint()
      ..shader = shader
      ..strokeCap = StrokeCap.round
      ..strokeWidth = math.max(2.0, spacing * 0.34);

    for (int i = 0; i < barCount; i++) {
      final x = spacing * (i + 1);
      final p = i / (barCount - 1);
      final distance = (p * 2 - 1).abs();

      // Enveloppe douce : la wave est plus haute au centre.
      final envelope = math
          .pow(math.max(0.015, 1 - distance * distance), 1.35)
          .toDouble();

      // Fréquences continues, avec des phases compatibles
      // au retour de l'animation à zéro.
      final wave1 = math.sin(phase - p * 2 * math.pi * 2);
      final wave2 = math.sin(phase * 2 + p * 2 * math.pi * 3);
      final wave3 = math.sin(phase * 3 - p * 2 * math.pi * 4);

      // Mélange doux : les barres voisines se suivent.
      final organicMotion = 0.52 + 0.20 * wave1 + 0.12 * wave2 + 0.06 * wave3;

      final idleMotion = 0.34 + 0.08 * wave1;
      final thinkingMotion = 0.38 + 0.12 * wave1;

      final motion = thinking
          ? thinkingMotion
          : recording
          ? organicMotion + amplitude * 0.9
          : idleMotion;

      final barHeight = (maxHeight * envelope * motion).clamp(2.5, maxHeight);

      final start = centerY - barHeight / 2;
      final end = centerY + barHeight / 2;

      canvas.drawLine(Offset(x, start), Offset(x, end), glowPaint);

      canvas.drawLine(Offset(x, start), Offset(x, end), barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _FluidWavePainter old) => true;
}

class GraceVoiceView extends StatefulWidget {
  const GraceVoiceView({super.key});

  @override
  State<GraceVoiceView> createState() => _GraceVoiceViewState();
}

class _GraceVoiceViewState extends State<GraceVoiceView> {
  final TextEditingController _controller = TextEditingController();

  final bool _isRecording = false;
  final double _amplitude = 0;
  String _message = 'Bonjour, je suis Grace. Comment puis-je t’aider ?';

  void _sendMessage() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    // context.read<SharaNavigationBloc>().add(
    //   SendGraceMessageEvent([
    //     {'role': 'user', 'content': text},
    //   ]),
    // );

    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AppScreen _screen = AppScreen.splash;
  int _navIndex = 0; // 0 = home, 1 = tasks, 2 = settings
  void _go(AppScreen s) => setState(() => _screen = s);
  void _goNav(int i) => setState(() {
    _navIndex = i;
    _screen = [AppScreen.home, AppScreen.tasks, AppScreen.settings][i];
  });

  void _navigateFromGrace(String destination) {
    final target = destination
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('-', '_');

    switch (target) {
      // Navigation principale
      case 'home':
      case 'accueil':
      case 'ouvrir_accueil':
        _goNav(0);
        break;

      case 'tasks':
      case 'taches':
      case 'mes_taches':
      case 'liste_taches':
        _go(AppScreen.manualCreate);
        break;

      case 'settings':
      case 'parametres':
        _goNav(2);
        break;

      // Création d'une tâche
      case 'create_task':
      case 'creer_tache':
      case 'nouvelle_tache':
      case 'creation_tache':
        _go(AppScreen.manualCreate);
        break;

      // Flux vocal
      case 'voice':
      case 'listening':
      case 'ecouter':
      case 'enregistrer':
        // _startListening();
        break;

      case 'transcription':
        _go(AppScreen.transcription);
        break;

      case 'confirmation':
      case 'confirmer_tache':
        _go(AppScreen.confirmation);
        break;

      case 'success':
      case 'succes':
        _go(AppScreen.success);
        break;

      // Sous-écrans des paramètres
      case 'appearance':
      case 'apparence':
        _go(AppScreen.settingsAppearance);
        break;

      case 'language':
      case 'langue':
        _go(AppScreen.settingsLanguage);
        break;

      case 'notifications':
      case 'notification':
        _go(AppScreen.settingsNotifications);
        break;

      case 'voice_settings':
      case 'parametres_vocaux':
        _go(AppScreen.settingsVoice);
        break;

      case 'data':
      case 'donnees':
        _go(AppScreen.settingsData);
        break;

      case 'about':
      case 'a_propos':
        _go(AppScreen.settingsAbout);
        break;

      case 'help':
      case 'aide':
        _go(AppScreen.settingsHelp);
        break;

      default:
        debugPrint('GraceNavigation : destination inconnue "$destination"');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SharaNavigationBloc, SharaNavigationState>(
      listener: (context, state) {
        if (state is SharaNavigationSuccess) {
          debugPrint('GRACE MESSAGE: ${state.response.message}');
          debugPrint('GRACE ACTION: ${state.response.action.type}');
          debugPrint('GRACE DESTINATION: ${state.response.action.destination}');
          setState(() {
            _message = state.response.message;
          });

          final action = state.response.action;

          if (action.destination != null &&
              action.destination!.trim().isNotEmpty) {
            switch (action.destination!.toLowerCase()) {
              case 'tasks':
              case 'mes_taches':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TasksScreen()),
                );
                break;

              case 'home':
              case 'accueil':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      tasks: [],
                      onMicTap: () {},
                      onViewTasks: () {},
                      onNotif: () {},
                    ),
                  ),
                );
                break;

              default:
                debugPrint('Destination inconnue : ${action.destination}');
            }
          }
        }

        if (state is SharaNavigationError) {
          setState(() {
            _message = state.message;
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF10111B),
        appBar: AppBar(
          title: const Text('Grace'),
          backgroundColor: const Color(0xFF10111B),
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: BlocBuilder<SharaNavigationBloc, SharaNavigationState>(
            builder: (context, state) {
              final isThinking = state is SharaNavigationLoading;

              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Spacer(),

                    VoiceWaveform(
                      isRecording: _isRecording,
                      isThinking: isThinking,
                      amplitude: _amplitude,
                      height: 160,
                    ),

                    const SizedBox(height: 32),

                    Text(
                      isThinking ? 'Grace réfléchit…' : _message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),

                    const Spacer(),

                    TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Dis quelque chose à Grace…',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF202130),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: isThinking ? null : _sendMessage,
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Color(0xFF7965FF),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// BlocConsumer<SharaNavigationBloc, SharaNavigationState>(
//   listener: (context, state) {
//     if (state is SharaNavigationSuccess) {
//           debugPrint('GRACE MESSAGE: ${state.response.message}');
//           debugPrint('GRACE ACTION: ${state.response.action.type}');
//           debugPrint('GRACE DESTINATION: ${state.response.action.destination}');
//           setState(() {
//             _message = state.response.message;
//           });

//           final action = state.response.action;

//           if (action.destination != null &&
//               action.destination!.trim().isNotEmpty) {
//             switch (action.destination!.toLowerCase()) {
//               case 'tasks':
//               case 'mes_taches':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TasksScreen()),
//                 );
//                 break;

//               case 'home':
//               case 'accueil':
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HomeScreen(
//                       tasks: [],
//                       onMicTap: () {},
//                       onViewTasks: () {},
//                       onNotif: () {},
//                     ),
//                   ),
//                 );
//                 break;

//               default:
//                 debugPrint('Destination inconnue : ${action.destination}');
//             }
//           }
//         }

//         if (state is SharaNavigationError) {
//           setState(() {
//             _message = state.message;
//           });
//         }
//   },
//   builder: (context, state) {
//     final isListening = state is SharaNavigationListening;
//     final isThinking = state is SharaNavigationLoading;
//     final amplitude = isListening ? state.amplitude : 0.0;
//     final message = switch (state) {
//       SharaNavigationSuccess(:final response) => response.message,
//       SharaNavigationError(:final message) => message,
//       SharaNavigationListening() => 'Je t’écoute…',
//       SharaNavigationLoading() => 'Shara réfléchit…',
//       _ => 'Dis « Shara » ou touche le micro.',
//     };

//     return Scaffold(
//       backgroundColor: const Color(0xFF10111B),
//       appBar: AppBar(title: const Text('Shara')),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               const Spacer(),
//               VoiceWaveform(
//                 isRecording: isListening,
//                 isThinking: isThinking,
//                 amplitude: amplitude,
//               ),
//               const SizedBox(height: 32),
//               Text(message,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white, fontSize: 18)),
//               const Spacer(),
//               IconButton.filled(
//                 iconSize: 36,
//                 onPressed: () => context.read<SharaNavigationBloc>().add(
//                       isListening
//                           ? SharaStopListening()
//                           : SharaStartListening(),
//                     ),
//                 icon: Icon(isListening ? Icons.stop : Icons.mic),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   },
// )

/// ========================
///                         AI
/// ========================
///

sealed class SharaNavigationEvent {}

class SharaWakeWordDetected extends SharaNavigationEvent {} // "Shara" entendu

class SharaStartListening extends SharaNavigationEvent {} // bouton micro

class SharaStopListening extends SharaNavigationEvent {}

class SharaAmplitudeChanged extends SharaNavigationEvent {
  SharaAmplitudeChanged(this.db);
  final double db;
}

// shara_navigation_state.dart
sealed class SharaNavigationState {}

class SharaNavigationIdle extends SharaNavigationState {}

class SharaNavigationListening extends SharaNavigationState {
  SharaNavigationListening(this.amplitude);
  final double amplitude; // 0..1
}

class SharaNavigationLoading extends SharaNavigationState {}

/// Réponse reçue : la vue navigue, le bloc lit le message à voix haute.
class SharaNavigationSuccess extends SharaNavigationState {
  SharaNavigationSuccess(this.response);
  final SharaResponse response;
}

class SharaNavigationError extends SharaNavigationState {
  SharaNavigationError(this.message);
  final String message;
}

// shara_navigation_bloc.dart
class SharaNavigationBloc
    extends Bloc<SharaNavigationEvent, SharaNavigationState> {
  SharaNavigationBloc({
    required SharaInteractUsecase interact,
    required AudioRecorder recorder,
    required FlutterTts tts,
    this.autoListenAfterReply = false,
  }) : _interact = interact,
       _recorder = recorder,
       _tts = tts,
       super(SharaNavigationIdle()) {
    on<SharaWakeWordDetected>(_onStart);
    on<SharaStartListening>(_onStart);
    on<SharaAmplitudeChanged>(_onAmplitude);
    on<SharaStopListening>(_onStop);
    _initTts();
  }

  final SharaInteractUsecase _interact;
  final AudioRecorder _recorder;
  final FlutterTts _tts;
  final bool autoListenAfterReply;

  static const _silenceThreshold = 0.25;
  static const _silenceDuration = Duration(milliseconds: 1500);
  static const _maxDuration = Duration(seconds: 30);

  final List<Map<String, String>> _history = [];
  StreamSubscription<Amplitude>? _ampSub;
  DateTime? _startedAt;
  DateTime _lastVoiceAt = DateTime.now();
  bool _heardSpeech = false;

  Future<void> _initTts() async {
    await _tts.setLanguage('fr-FR');
    await _tts.setSpeechRate(0.5);
    await _tts.awaitSpeakCompletion(true);
  }

  Future<void> _onStart(
    SharaNavigationEvent event,
    Emitter<SharaNavigationState> emit,
  ) async {
    // Ignore le wake word pendant l'écoute, la réflexion ou la lecture.
    if (state is SharaNavigationListening ||
        state is SharaNavigationLoading ||
        state is SharaNavigationSuccess) {
      return;
    }

    if (!await _recorder.hasPermission()) {
      emit(SharaNavigationError('Autorise le micro pour parler à Shara.'));
      return;
    }

    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/shara_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );

    _startedAt = DateTime.now();
    _lastVoiceAt = _startedAt!;
    _heardSpeech = false;

    _ampSub = _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 80))
        .listen((a) => add(SharaAmplitudeChanged(a.current)));

    emit(SharaNavigationListening(0));
  }

  void _onAmplitude(
    SharaAmplitudeChanged event,
    Emitter<SharaNavigationState> emit,
  ) {
    if (state is! SharaNavigationListening) return;

    // dB (-160..0) -> 0..1
    final level = ((event.db + 50) / 50).clamp(0.0, 1.0);
    final now = DateTime.now();

    if (level > _silenceThreshold) {
      _heardSpeech = true;
      _lastVoiceAt = now;
    }

    emit(SharaNavigationListening(level));

    final silent =
        _heardSpeech && now.difference(_lastVoiceAt) > _silenceDuration;
    final tooLong = now.difference(_startedAt!) > _maxDuration;
    if (silent || tooLong) add(SharaStopListening());
  }

  Future<void> _onStop(
    SharaStopListening event,
    Emitter<SharaNavigationState> emit,
  ) async {
    if (state is! SharaNavigationListening) return;
    emit(SharaNavigationLoading());

    await _ampSub?.cancel();
    final path = await _recorder.stop();
    final seconds = DateTime.now().difference(_startedAt!).inSeconds;

    // Rien entendu : on ne gaspille pas un appel API.
    if (path == null || !_heardSpeech) {
      emit(SharaNavigationIdle());
      return;
    }

    final result = await _interact({
      'audioPath': path,
      'history': List<Map<String, String>>.from(_history),
      'recordTime': seconds,
    });

    SharaResponse? response;
    Failure? failure;
    result.fold(
      (l) => failure = l,
      (r) => response = SharaResponse(action: r.action, message: r.message),
    );

    if (failure != null || response == null) {
      emit(SharaNavigationError(failure?.message ?? 'Erreur inconnue'));
      return;
    }

    final r = response!;

    _history
      ..add({'role': 'user', 'content': r.transcript})
      ..add({'role': 'assistant', 'content': r.message});
    if (_history.length > 12) _history.removeRange(0, _history.length - 12);

    emit(SharaNavigationSuccess(r)); // la vue navigue / crée la tâche
    await _tts.speak(r.message); // attend la fin de la lecture
    emit(SharaNavigationIdle());

    // Mode conversation : si Shara a posé une question, on réécoute.
    if (autoListenAfterReply && r.action.type == 'none') {
      add(SharaStartListening());
    }
  }

  @override
  Future<void> close() async {
    await _ampSub?.cancel();
    await _tts.stop();
    await _recorder.dispose();
    return super.close();
  }
}

class SharaResponse {
  final String message;
  final SharaAction action;
  final String transcript; // texte de l'utilisateur, rempli par le repository

  const SharaResponse({
    required this.message,
    required this.action,
    this.transcript = '',
  });

  SharaResponse copyWith({String? transcript}) => SharaResponse(
    message: message,
    action: action,
    transcript: transcript ?? this.transcript,
  );
}
