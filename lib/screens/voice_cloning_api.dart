import 'dart:convert';
import 'package:http/http.dart' as http;

class VoiceCloningAPI {
  final String apiUrl = "https://api.resemble.ai/v1/speech";  // Example URL, replace with actual service API
  final String apiKey = "YOUR_API_KEY";  // Replace with your API key

  // Function to clone voice and get the audio URL
  Future<String> cloneVoice(String textToSpeak) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'text': textToSpeak,
        'voice': 'custom_voice_id',  // Replace with the cloned voice ID you created
        'emotion': 'neutral',  // Optional: Adjust emotion if the API supports it
      }),
    );

    if (response.statusCode == 200) {
      // API returns URL of the generated audio file
      var data = json.decode(response.body);
      return data['audio_url'];  // Assuming the API returns an audio URL
    } else {
      throw Exception('Failed to clone voice');
    }
  }
}

