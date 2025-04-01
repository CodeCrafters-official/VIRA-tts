import 'package:flutter/material.dart';
import 'home_screen.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  List<String> words = ["Voice", "Is", "Really", "Alive", "VIRA"];
  int index = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < words.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      setState(() => index = i);
    }
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          words[index],
          style: TextStyle(fontSize: 150, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
