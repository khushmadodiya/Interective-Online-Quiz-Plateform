import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_platform/main.dart';
import 'package:quiz_platform/screens/faculty/facultyScreen.dart';
import 'package:quiz_platform/screens/student/studentscreen.dart';

class AuthScreen extends StatefulWidget {
  final name;
  final bool isst;
  const AuthScreen({super.key, required this.name,  this.isst=false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      Duration(seconds: 1),
          () async {
        await getphotourl(widget.name, context);
        if (widget.isst) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FacultyScreen()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // Cancel the timer to prevent errors
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
