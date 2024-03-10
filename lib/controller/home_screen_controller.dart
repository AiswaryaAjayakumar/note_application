import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreenController {
  // List noteList = [];
  List noteKeys = [];

  var myBox = Hive.box("note");
  

  void addData(String title, String des, String date, int selectedColorIndex) {
    myBox.add(
      {"title": title, "des": des, "date": date, "color": selectedColorIndex},
    );

    noteKeys = myBox.keys.toList();
  }

  void init() {
    noteKeys = myBox.keys.toList();
  }

  void deleteData(var key) {
    myBox.delete(key);
    noteKeys = myBox.keys.toList();
  }
}
