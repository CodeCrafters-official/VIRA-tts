import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EmotionStoryScreen extends StatefulWidget {
  @override
  _EmotionStoryScreenState createState() => _EmotionStoryScreenState();
}

class _EmotionStoryScreenState extends State<EmotionStoryScreen> {
  FlutterTts flutterTts = FlutterTts();
  String? selectedEmotion;
  String generatedStory = "Select an emotion and generate a story!";
  bool isSpeaking = false;

  final List<String> emotions = ["Happy", "Sad", "Excited", "Scared", "Angry", "Surprised"];

  final Map<String, List<String>> storyParts = {
    "Happy": [
      "Lily lived in a beautiful village surrounded by flowers and friendly people.",
      "One day, she found an injured bird and decided to care for it with love and patience.",
      "As the bird healed, it started visiting Lily every morning, singing cheerful songs that filled her heart with joy."
    ],
    "Sad": [
      "Robert sat alone on the old park bench, holding a faded photograph of his late wife.",
      "He remembered the days when they used to sit there together, sharing stories and laughter.",
      "Now, as the leaves fell around him, he realized that while she was gone, her love remained in his heart forever."
    ],
    "Excited": [
      "Jack had always dreamed of exploring space, and today was the day his dream came true.",
      "As the rocket engines ignited, his heart pounded with excitement, ready for the adventure ahead.",
      "Looking out at the endless galaxy, he knew this was just the beginning of something extraordinary."
    ],
    "Scared": [
      "Ethan walked into the abandoned mansion, its wooden floors creaking under his feet.",
      "A sudden whisper echoed through the hall, sending shivers down his spine.",
      "Just as he turned to run, the lights flickered on, revealing his friends laughing—it was all a prank!"
    ],
    "Angry": [
      "Liam watched as corrupt officials took bribes, making unfair decisions that hurt the poor.",
      "Determined to bring justice, he gathered evidence and exposed their crimes.",
      "With the truth revealed, people stood together, proving that one voice could spark a revolution."
    ],
    "Surprised": [
      "Emma opened the dusty wooden chest in the attic, her heart pounding with curiosity.",
      "Inside, she found a golden key and an old letter revealing a long-lost family secret.",
      "As she read the words, she realized her family’s history was far more extraordinary than she had ever imagined."
    ],
  };

  void generateStory() {
    if (selectedEmotion == null) {
      setState(() {
        generatedStory = "Please select an emotion first!";
      });
      return;
    }

    List<String> parts = storyParts[selectedEmotion]!;
    String story = "${parts[0]}\n\n${parts[1]}\n\n${parts[2]}";

    setState(() {
      generatedStory = story;
    });
  }

  Future<void> speakStory() async {
    if (generatedStory.isNotEmpty) {
      await flutterTts.speak(generatedStory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Emotion Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Select an Emotion:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: emotions.map((emotion) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ChoiceChip(
                          label: Text(emotion, style: TextStyle(fontSize: 16)),
                          selected: selectedEmotion == emotion,
                          selectedColor: Colors.blueAccent,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedEmotion = selected ? emotion : null;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Story Display
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2)
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          generatedStory,
                          style: TextStyle(fontSize: 16, height: 1.5),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),

                // Generate & Speak Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      // Generate Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: generateStory,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text("Generate Story", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      SizedBox(width: 10),

                      // Speak Button
                      ElevatedButton(
                        onPressed: speakStory,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(14),
                          shape: CircleBorder(),
                          backgroundColor: Colors.green,
                        ),
                        child: Icon(Icons.volume_up, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Logo at Right-Center - Big Size
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset('assets/story.png', width: 500), // Adjust the size here
            ),
          ),
        ],
      ),
    );
  }
}
