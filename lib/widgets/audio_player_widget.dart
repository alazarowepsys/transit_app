import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({required this.path, super.key});

  final String path;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(widget.path));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.setSourceDeviceFile(widget.path);
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(200),
        ),
        onPressed: _toggleAudio,
        label: Text(
          _isPlaying ? "Pausar" : "Reproducir",
          style: GoogleFonts.gabarito(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
