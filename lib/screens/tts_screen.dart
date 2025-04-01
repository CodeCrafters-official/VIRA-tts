import 'package:flutter/material.dart';

class TTSScreen extends StatefulWidget {
  @override
  _TTSScreenState createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {
  TextEditingController _controller = TextEditingController();

  void _speakText() {
    // Trigger your TTS functionality here
    String textToConvert = _controller.text;
    print("Text to speak: $textToConvert");
    // Call your backend or TTS API to convert text to speech
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VIRA - TTS Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _speakText,
              child: Text('Convert to Speech'),
            ),
          ],
        ),
      ),
    );
  }
}
