import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechScreen extends StatefulWidget {
  @override
  _TextToSpeechScreenState createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  TextEditingController _textController = TextEditingController();

  bool isPlaying = false;
  bool isPaused = false;
  String selectedLanguage = "en-US";
  double speechRate = 0.5;
  double pitch = 1.0;

  List<Map<String, String>> languages = [
    {"name": "English (US)", "code": "en-US"},
    {"name": "English (UK)", "code": "en-GB"},
    {"name": "Spanish", "code": "es-ES"},
    {"name": "French", "code": "fr-FR"},
    {"name": "German", "code": "de-DE"},
    {"name": "Hindi", "code": "hi-IN"},
    {"name": "Tamil", "code": "ta-IN"},
    {"name": "Japanese", "code": "ja-JP"},
  ];

  @override
  void initState() {
    super.initState();
    _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setLanguage(selectedLanguage);
  }

  Future<void> _speak() async {
    if (_textController.text.isEmpty) return;

    await _flutterTts.setLanguage(selectedLanguage);
    await _flutterTts.setSpeechRate(speechRate);
    await _flutterTts.setPitch(pitch);
    await _flutterTts.speak(_textController.text);

    setState(() {
      isPlaying = true;
      isPaused = false;
    });
  }

  void _pauseSpeech() {
    _flutterTts.pause();
    setState(() {
      isPaused = true;
      isPlaying = false;
    });
  }

  void _stopSpeech() {
    _flutterTts.stop();
    setState(() {
      isPlaying = false;
      isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🌎 Language Selection
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Language", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      DropdownButton<String>(
                        value: selectedLanguage,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue!;
                            _flutterTts.setLanguage(selectedLanguage);
                          });
                        },
                        items: languages.map<DropdownMenuItem<String>>((language) {
                          return DropdownMenuItem<String>(
                            value: language['code'],
                            child: Text(language['name']!),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // 📝 Input Box
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _textController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Enter text',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // 🎛️ Sliders for Speech Rate & Pitch
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Speech Rate: ${speechRate.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Slider(
                            value: speechRate,
                            min: 0.1,
                            max: 1.5,
                            onChanged: (value) {
                              setState(() {
                                speechRate = value;
                              });
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pitch: ${pitch.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Slider(
                            value: pitch,
                            min: 0.5,
                            max: 2.0,
                            onChanged: (value) {
                              setState(() {
                                pitch = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // 🎵 Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _speak,
                    icon: Icon(Icons.play_arrow, color: Colors.white),
                    label: Text("Play"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _pauseSpeech,
                    icon: Icon(Icons.pause, color: Colors.white),
                    label: Text("Pause"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade600),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _stopSpeech,
                    icon: Icon(Icons.stop, color: Colors.white),
                    label: Text("Stop"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
