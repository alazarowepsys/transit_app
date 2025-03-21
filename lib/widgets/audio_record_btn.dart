// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecordButton extends StatefulWidget {
  const AudioRecordButton({super.key, required this.onRecorded});

  final void Function(String) onRecorded;

  @override
  State<AudioRecordButton> createState() => _AudioRecordButtonState();
}

class _AudioRecordButtonState extends State<AudioRecordButton> {
  bool _isRecording = false;
  final AudioRecorder _recorder = AudioRecorder();
  String? _audioFilePath;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: !_isRecording ? _recordAudio : () => _stopRecording(context),
      icon:
          !_isRecording
              ? Icon(Icons.mic_rounded, color: Colors.white, size: 20)
              : Icon(Icons.mic_off_rounded, color: Colors.white, size: 20),
      label: Text(
        !_isRecording ? "Toca para grabar" : "Toca para detener la grabación",
        style: GoogleFonts.gabarito(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _recordAudio() async {
    if (_isRecording) {
    } else {
      if (await _recorder.hasPermission()) {
        final Directory docsDir = (await getDownloadsDirectory())!;
        String recordPath = join(
          docsDir.path,
          "${DateTime.now().millisecondsSinceEpoch.toString()}record.wav",
        );
        await _recorder.start(
          RecordConfig(encoder: AudioEncoder.wav),
          path: recordPath,
        );
        setState(() {
          _isRecording = true;
        });
      }
    }
  }

  Future<void> _stopRecording(BuildContext context) async {
    final String? filePath = await _recorder.stop();
    setState(() {
      _isRecording = false;
    });

    if (filePath == null) return;

    _audioFilePath = filePath;
    widget.onRecorded(_audioFilePath!);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Audio grabado correctamente.")));
  }

  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }
}
