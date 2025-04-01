  import 'package:flutter/material.dart';
  import 'profile_screen.dart';
  import 'settings_screen.dart';
  import 'text_to_speech.dart';
  import 'translator.dart';
  import 'emotion_story_screen.dart'; // Import the new story screen

  class HomeScreen extends StatefulWidget {
    @override
    _HomeScreenState createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    int _selectedIndex = 0;

    final List<Widget> _screens = [
      TextToSpeechScreen(),
      TranslatorScreen(),
      EmotionStoryScreen(), // Add the story screen to bottom navigation if needed
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(child: Image.asset('assets/logo.png', width: 180)),
              SizedBox(height: 10),
              Divider(),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
              ),
              Divider(),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.record_voice_over), label: "Text-to-Speech"),
            BottomNavigationBarItem(icon: Icon(Icons.translate), label: "Translator"),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Stories"),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }
  }
