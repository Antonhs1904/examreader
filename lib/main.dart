import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudyAidScreen(),
    );  
  }
}

class StudyAidScreen extends StatefulWidget {
  @override
  _StudyAidScreenState createState() => _StudyAidScreenState();
}

class _StudyAidScreenState extends State<StudyAidScreen> {
  TextEditingController _textController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  AudioPlayer audioPlayer = AudioPlayer();
  String? mp3FilePath;

  @override
  void dispose() {
    _textController.dispose();
    flutterTts.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _convertTextToSpeech() async {
    String text = _textController.text;
    if (text.isEmpty) {
      return;
    }

    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filePath = path.join(tempPath, 'speech.mp3');

    // Convert text to speech and save as an MP3 file
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.synthesizeToFile(text, filePath);

    setState(() {
      mp3FilePath = filePath;
    });
  }

  Future<void> _playMp3() async {
    if (mp3FilePath == null) {
      return;
    }

    // Check if the file exists
    final file = File(mp3FilePath!);
    if (!await file.exists()) {
      print('File does not exist: $mp3FilePath');
      return;
    }

    // Set the source for the AudioPlayer
    await audioPlayer.setSource(DeviceFileSource(mp3FilePath!));

    // Play the audio
    await audioPlayer.resume();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Aid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null, // Expands infinitely based on content
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTextToSpeech,
              child: Text('Convert to Speech'),
            ),
            SizedBox(height: 20),
            if (mp3FilePath != null)
              ElevatedButton(
                onPressed: _playMp3,
                child: Text('Play MP3'),
              ),
            Expanded(
              child: ListView(
                children: [
                  // Add code to display saved MP3 files
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
