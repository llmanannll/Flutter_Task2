import 'package:flutter/material.dart';
import 'package:stroll_task2/Screen/audio_recorder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'audio_recorder',
      routes: {
        'audio_recorder': (context) => AudioRecorder(),
      },
    );
  }
}
