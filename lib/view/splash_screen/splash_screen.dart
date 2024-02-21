// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_application/view/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 250, 250),
      body: Center(
        child: Image(
          image: NetworkImage(
              "https://is1-ssl.mzstatic.com/image/thumb/Purple112/v4/70/53/35/705335b6-2946-0cc7-9481-d0a73235faef/AppIcon-0-0-2x_U007euniversal-0-4-85-220.png/1200x630wa.png",
              scale: 1),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
