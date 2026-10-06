// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:record/record.dart';
// // import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
// // import 'package:grace_church/feature/home/domaine/usecase/create_task_from_voice.dart';

// // sealed class VoiceTaskState {}

// // class VoiceIdle extends VoiceTaskState {}

// // class VoiceRecording extends VoiceTaskState {}

// // class VoiceLoading extends VoiceTaskState {}

// // class VoiceSuccess extends VoiceTaskState {
// //   VoiceSuccess(this.result);
// //   final TaskResponse result;
// // }

// // class VoiceError extends VoiceTaskState {
// //   VoiceError(this.message);
// //   final String message;
// // }

// // class VoiceTaskCubit extends Cubit<VoiceTaskState> {
// //   VoiceTaskCubit({required this.createTask, required this.recorder})
// //     : super(VoiceIdle());

// //   final CreateTaskFromVoiceUseCase createTask;
// //   final VoiceRecorder recorder;

// //   Future<void> start() async {
// //     if (state is VoiceRecording || state is VoiceLoading) return;
// //     final started = await recorder.start();
// //     if (started) {
// //       emit(VoiceRecording());
// //     } else {
// //       emit(VoiceError('Permission micro refusée'));
// //     }
// //   }

// //   Future<void> stopAndSend() async {
// //     if (state is! VoiceRecording) return;

// //     final path = await recorder.stop();
// //     if (path == null) return emit(VoiceError('Aucun enregistrement'));

// //     emit(VoiceLoading());
// //     final result = await createTask(path);
// //     result.fold(
// //       (failure) => emit(VoiceError(failure.message)),
// //       (data) => emit(VoiceSuccess(data)),
// //     );
// //   }

// //   void reset() => emit(VoiceIdle());

// //   @override
// //   Future<void> close() async {
// //     await recorder.dispose();
// //     return super.close();
// //   }
// // }

// // class VoiceRecorder {
// //   final _rec = AudioRecorder();

// //   Future<bool> start() async {
// //     if (!await _rec.hasPermission()) return false;
// //     final dir = await getTemporaryDirectory();
// //     await _rec.start(
// //       const RecordConfig(encoder: AudioEncoder.aacLc),
// //       path: '${dir.path}/vocal.m4a',
// //     );
// //     return true;
// //   }

// //   /// Retourne le chemin du fichier, ou null si rien n'a été enregistré
// //   Future<String?> stop() => _rec.stop();

// //   Future<void> dispose() => _rec.dispose();
// // }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
// import 'package:grace_church/feature/home/domaine/usecase/create_task_from_voice.dart';

// sealed class VoiceTaskState {}

// class VoiceIdle extends VoiceTaskState {}

// class VoiceRecording extends VoiceTaskState {}

// class VoicePaused extends VoiceTaskState {}

// class VoiceLoading extends VoiceTaskState {}

// class VoiceSuccess extends VoiceTaskState {
//   VoiceSuccess(this.result);
//   final TaskResponse result;
// }

// class VoiceError extends VoiceTaskState {
//   VoiceError(this.message);
//   final String message;
// }

// class VoiceTaskCubit extends Cubit<VoiceTaskState> {
//   VoiceTaskCubit({required this.createTask, required this.recorder})
//     : super(VoiceIdle());

//   final CreateTaskFromVoiceUseCase createTask;
//   final VoiceRecorder recorder;

//   Future<void> start() async {
//     if (state is VoiceRecording ||
//         state is VoicePaused ||
//         state is VoiceLoading) {
//       return;
//     }
//     final started = await recorder.start();
//     if (started) {
//       emit(VoiceRecording());
//     } else {
//       emit(VoiceError('Permission micro refusée'));
//     }
//   }

//   Future<void> pause() async {
//     if (state is! VoiceRecording) return;
//     await recorder.pause();
//     emit(VoicePaused());
//   }

//   Future<void> resume() async {
//     if (state is! VoicePaused) return;
//     await recorder.resume();
//     emit(VoiceRecording());
//   }

//   Future<void> stopAndSend() async {
//     if (state is! VoiceRecording && state is! VoicePaused) return;

//     final path = await recorder.stop();
//     if (path == null) return emit(VoiceError('Aucun enregistrement'));

//     emit(VoiceLoading());
//     final result = await createTask(path);
//     result.fold(
//       (failure) => emit(VoiceError(failure.message)),
//       (data) => emit(VoiceSuccess(data)),
//     );
//   }

//   void reset() => emit(VoiceIdle());

//   @override
//   Future<void> close() async {
//     await recorder.dispose();
//     return super.close();
//   }
// }

// class VoiceRecorder {
//   final _rec = AudioRecorder();

//   Future<bool> start() async {
//     if (!await _rec.hasPermission()) return false;
//     final dir = await getTemporaryDirectory();
//     await _rec.start(
//       const RecordConfig(encoder: AudioEncoder.aacLc),
//       path: '${dir.path}/vocal.m4a',
//     );
//     return true;
//   }

//   Future<void> pause() => _rec.pause();

//   Future<void> resume() => _rec.resume();

//   /// Retourne le chemin du fichier, ou null si rien n'a été enregistré
//   Future<String?> stop() => _rec.stop();

//   Future<void> dispose() => _rec.dispose();
// }


import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:grace_church/feature/home/domaine/entities/response/home_responses.dart';
import 'package:grace_church/feature/home/domaine/usecase/create_task_from_voice.dart';

sealed class VoiceTaskState {}

class VoiceIdle extends VoiceTaskState {}

class VoiceRecording extends VoiceTaskState {}

class VoicePaused extends VoiceTaskState {}

class VoiceStopped extends VoiceTaskState {
  VoiceStopped(this.path, this.duration);
  final String path;
  final Duration duration;
}

class VoiceLoading extends VoiceTaskState {}

class VoiceSuccess extends VoiceTaskState {
  VoiceSuccess(this.result);
  final TaskResponse result;
}

class VoiceError extends VoiceTaskState {
  VoiceError(this.message);
  final String message;
}

class VoiceTaskCubit extends Cubit<VoiceTaskState> {
  VoiceTaskCubit({required this.createTask, required this.recorder})
    : super(VoiceIdle()) {
    _recorderSub = recorder.onStateChanged().listen(_onRecorderState);
  }

  static const _minDuration = Duration(seconds: 1);

  final CreateTaskFromVoiceUseCase createTask;
  final VoiceRecorder recorder;

  final Stopwatch _watch = Stopwatch();
  StreamSubscription<RecordState>? _recorderSub;
  bool _busy = false;

  /// Durée enregistrée (figée en pause).
  Duration get elapsed => _watch.elapsed;

  void _safeEmit(VoiceTaskState s) {
    if (!isClosed) emit(s);
  }

  /// Évite les doubles appuis pendant une opération asynchrone.
  Future<void> _guard(Future<void> Function() action) async {
    if (_busy) return;
    _busy = true;
    try {
      await action();
    } finally {
      _busy = false;
    }
  }

  /// Interruption externe (appel entrant, autre app audio...).
  void _onRecorderState(RecordState s) {
    if (_busy) return;
    if (s == RecordState.pause && state is VoiceRecording) {
      _watch.stop();
      _safeEmit(VoicePaused());
    }
  }

  Future<void> _begin() async {
    try {
      final started = await recorder.start();
      if (!started) {
        return _safeEmit(VoiceError('Permission micro refusée'));
      }
      _watch
        ..reset()
        ..start();
      _safeEmit(VoiceRecording());
    } catch (_) {
      _safeEmit(VoiceError("Impossible de démarrer l'enregistrement"));
    }
  }

  Future<void> start() => _guard(() async {
    if (state is VoiceRecording ||
        state is VoicePaused ||
        state is VoiceStopped ||
        state is VoiceLoading) {
      return;
    }
    await _begin();
  });

  Future<void> pause() => _guard(() async {
    if (state is! VoiceRecording) return;
    try {
      await recorder.pause();
      _watch.stop();
      _safeEmit(VoicePaused());
    } catch (_) {
      _safeEmit(VoiceError('Impossible de mettre en pause'));
      _safeEmit(VoiceRecording());
    }
  });

  Future<void> resume() => _guard(() async {
    if (state is! VoicePaused) return;
    try {
      await recorder.resume();
      _watch.start();
      _safeEmit(VoiceRecording());
    } catch (_) {
      _safeEmit(VoiceError('Impossible de reprendre'));
      _safeEmit(VoicePaused());
    }
  });

  /// Termine l'enregistrement et passe en mode écoute.
  Future<void> stop() => _guard(() async {
    if (state is! VoiceRecording && state is! VoicePaused) return;
    _watch.stop();
    try {
      final path = await recorder.stop();
      if (path == null) {
        return _safeEmit(VoiceError('Aucun enregistrement'));
      }
      if (_watch.elapsed < _minDuration) {
        await recorder.deleteFile();
        return _safeEmit(VoiceError('Enregistrement trop court'));
      }
      _safeEmit(VoiceStopped(path, _watch.elapsed));
    } catch (_) {
      _safeEmit(VoiceError("Erreur à l'arrêt de l'enregistrement"));
    }
  });

  /// Envoie l'enregistrement validé. En cas d'échec, on revient à l'écoute
  /// pour pouvoir renvoyer sans réenregistrer.
  Future<void> send() => _guard(() async {
    final current = state;
    if (current is! VoiceStopped) return;

    _safeEmit(VoiceLoading());
    try {
      final result = await createTask(current.path);
      result.fold(
        (failure) {
          _safeEmit(VoiceError(failure.message));
          _safeEmit(current);
        },
        (data) => _safeEmit(VoiceSuccess(data)),
      );
    } catch (_) {
      _safeEmit(VoiceError('Erreur réseau, veuillez réessayer'));
      _safeEmit(current);
    }
  });

  /// Supprime l'enregistrement et repart de zéro.
  Future<void> restart() => _guard(() async {
    if (state is! VoiceStopped) return;
    await recorder.deleteFile();
    await _begin();
  });

  /// Abandonne tout (enregistrement en cours ou terminé).
  Future<void> cancel() => _guard(() async {
    if (state is VoiceLoading) return;
    _watch
      ..stop()
      ..reset();
    try {
      await recorder.cancel();
    } catch (_) {}
    await recorder.deleteFile();
    _safeEmit(VoiceIdle());
  });

  void reset() => emit(VoiceIdle());

  @override
  Future<void> close() async {
    await _recorderSub?.cancel();
    try {
      await recorder.dispose();
    } catch (_) {}
    await recorder.deleteFile();
    return super.close();
  }
}

class VoiceRecorder {
  final _rec = AudioRecorder();
  String? _path;

  Stream<RecordState> onStateChanged() => _rec.onStateChanged();

  Future<bool> start() async {
    if (!await _rec.hasPermission()) return false;
    final dir = await getTemporaryDirectory();
    // Nom unique : évite que le lecteur serve un ancien fichier en cache.
    _path = '${dir.path}/vocal_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _rec.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: _path!,
    );
    return true;
  }

  Future<void> pause() => _rec.pause();

  Future<void> resume() => _rec.resume();

  /// Retourne le chemin du fichier, ou null si rien n'a été enregistré
  Future<String?> stop() => _rec.stop();

  /// Arrête et supprime l'enregistrement en cours.
  Future<void> cancel() => _rec.cancel();

  Future<void> deleteFile() async {
    final p = _path;
    _path = null;
    if (p == null) return;
    try {
      final f = File(p);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  Future<void> dispose() => _rec.dispose();
}