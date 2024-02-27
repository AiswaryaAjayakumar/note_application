import 'package:flutter/material.dart';

class HomeScreenController {
  List noteList = [];

  void addData(String title, String des, String date, Color selectedColor) {
    noteList.add(
      {"title": title, "des": des, "date": date, "color": selectedColor},
    );
  }

  void deleteData(int index) {
    noteList.removeAt(index);
  }

 
}
