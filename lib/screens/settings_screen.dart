import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load language preference
  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? "English";
    });
  }

  // Save language setting
  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLanguage', selectedLanguage);
  }

  // Logout function (redirects to login screen)
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears user data

    // Navigate to login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Back Icon Only (No Header Color, No Title)
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Go back to previous screen
              },
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // 🌍 Language Selection
                ListTile(
                  title: Text("App Language"),
                  subtitle: Text(selectedLanguage),
                  leading: Icon(Icons.language),
                  onTap: () => _showLanguageDialog(),
                ),

                Divider(),

                // 🔒 Privacy & Security
                ListTile(
                  title: Text("Manage Permissions"),
                  leading: Icon(Icons.security),
                  onTap: () {
                    // Navigate to Manage Permissions
                  },
                ),
                ListTile(
                  title: Text("Enable App Lock"),
                  leading: Icon(Icons.lock_outline),
                  onTap: () {
                    // Navigate to App Lock Settings
                  },
                ),

                Divider(),

                // ❓ Help & Support
                ListTile(
                  title: Text("FAQs"),
                  leading: Icon(Icons.help_outline),
                  onTap: () {
                    // Navigate to FAQs Screen
                  },
                ),
                ListTile(
                  title: Text("Contact Support"),
                  leading: Icon(Icons.support_agent),
                  onTap: () {
                    // Navigate to Contact Support Screen
                  },
                ),

                Divider(),

                // 🚪 Logout (Fix: Redirects properly now)
                ListTile(
                  title: Text("Logout", style: TextStyle(color: Colors.red)),
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 📜 Language Selection Dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption("English"),
              _buildLanguageOption("Tamil"),
              _buildLanguageOption("Hindi"),
              _buildLanguageOption("French"),
            ],
          ),
        );
      },
    );
  }

  // 🎭 Language Option Widget
  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        setState(() => selectedLanguage = language);
        _saveSettings();
        Navigator.pop(context); // Close dialog
      },
    );
  }
}
