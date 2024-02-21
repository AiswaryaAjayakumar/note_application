// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_application/view/home_screen/home_screen.dart';

import 'package:note_application/view/splash_screen/splash_screen.dart';

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
