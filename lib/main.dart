import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


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
              onPressed: () {
                // Add your text-to-speech conversion code here
              },
              child: Text('Convert to Speech'),
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
