import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  TextEditingController _textController = TextEditingController();
  String _translatedText = "";

  final translator = GoogleTranslator();

  // 🌍 Supported languages with their codes
  Map<String, String> languages = {
    "English": "en",
    "Spanish": "es",
    "French": "fr",
    "German": "de",
    "Hindi": "hi",
    "Tamil": "ta",
    "Chinese": "zh-cn",
    "Japanese": "ja",
  };

  // Default selected languages
  String inputLanguage = "en"; // English
  String outputLanguage = "es"; // Spanish

  Future<void> _translateText() async {
    String inputText = _textController.text;
    if (inputText.isNotEmpty) {
      var translation = await translator.translate(inputText, from: inputLanguage, to: outputLanguage);
      setState(() {
        _translatedText = translation.text;
      });
    }
  }

  // 🗑️ Clear input & output text
  void _clearText() {
    setState(() {
      _textController.clear();
      _translatedText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🎨 Input Box
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🌍 Input Language Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Input Language:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            DropdownButton<String>(
                              value: inputLanguage,
                              onChanged: (String? newValue) {
                                setState(() {
                                  inputLanguage = newValue!;
                                });
                              },
                              items: languages.entries.map<DropdownMenuItem<String>>((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.value,
                                  child: Text(entry.key),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        // 📝 Input Text Field
                        TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            labelText: "Enter text",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // 🔵 Translate & Clear Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _translateText,
                      icon: Icon(Icons.translate, color: Colors.white),
                      label: Text("Translate"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _clearText,
                      icon: Icon(Icons.clear, color: Colors.white),
                      label: Text("Clear"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // 🎨 Output Box
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🌍 Output Language Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Output Language:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            DropdownButton<String>(
                              value: outputLanguage,
                              onChanged: (String? newValue) {
                                setState(() {
                                  outputLanguage = newValue!;
                                });
                              },
                              items: languages.entries.map<DropdownMenuItem<String>>((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.value,
                                  child: Text(entry.key),
                                );
                              }).toList(),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        // 📌 Translated Text Output
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _translatedText.isNotEmpty ? _translatedText : "Translation will appear here...",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
