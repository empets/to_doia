import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:to_doia/feature/home/domaine/entities/response/home_responses.dart';
import 'package:to_doia/feature/home/domaine/usecase/create_task_from_voice.dart';

sealed class VoiceTaskState {}

class VoiceIdle extends VoiceTaskState {}

class VoiceRecording extends VoiceTaskState {}

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
    : super(VoiceIdle());

  final CreateTaskFromVoiceUseCase createTask;
  final VoiceRecorder recorder;

  Future<void> start() async {
    if (state is VoiceRecording || state is VoiceLoading) return;
    final started = await recorder.start();
    if (started) {
      emit(VoiceRecording());
    } else {
      emit(VoiceError('Permission micro refusée'));
    }
  }

  Future<void> stopAndSend() async {
    if (state is! VoiceRecording) return;

    final path = await recorder.stop();
    if (path == null) return emit(VoiceError('Aucun enregistrement'));

    emit(VoiceLoading());
    final result = await createTask(path);
    result.fold(
      (failure) => emit(VoiceError(failure.message)),
      (data) => emit(VoiceSuccess(data)),
    );
  }

  void reset() => emit(VoiceIdle());

  @override
  Future<void> close() async {
    await recorder.dispose();
    return super.close();
  }
}

class VoiceRecorder {
  final _rec = AudioRecorder();

  Future<bool> start() async {
    if (!await _rec.hasPermission()) return false;
    final dir = await getTemporaryDirectory();
    await _rec.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: '${dir.path}/vocal.m4a',
    );
    return true;
  }

  /// Retourne le chemin du fichier, ou null si rien n'a été enregistré
  Future<String?> stop() => _rec.stop();

  Future<void> dispose() => _rec.dispose();
}
