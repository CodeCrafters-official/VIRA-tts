import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔙 Back Button Only (No Header Color)
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Go back
              },
            ),
          ),

          // 🧑 Profile Picture & Name
          Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Nithin S", // Replace with actual user name
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "nithinsathish05@gmail.com", // Replace with actual email
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // 📋 User Details Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildProfileItem(Icons.phone, "Phone", "+91 8124703220"),
                _buildProfileItem(Icons.location_on, "Address", "Chennai, India"),
                _buildProfileItem(Icons.work, "Occupation", "Student"),
                _buildProfileItem(Icons.calendar_today, "Date of Birth", "Nov 14, 2005"),
                _buildProfileItem(Icons.people, "Gender", "Male"),
                SizedBox(height: 20),

                // ✏️ Edit Profile Button
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Edit Profile
                  },
                  child: Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),

                SizedBox(height: 10),

                // 🚪 Logout Button
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  child: Text("Logout", style: TextStyle(color: Colors.red, fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Helper Widget for Profile Info
  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: TextStyle(color: Colors.grey[700])),
      ),
    );
  }
}
