import 'package:flutter/material.dart';

class HomeScreenController {

   static Color selectedColor = Colors.green;

  List noteList = [
    {
      "title": "Title",
      "des":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "date": "Date",
      "color": Colors.white
    },
  ];

  void addData({required String title, required String des, required String date})
       {
    noteList.add(
      { "title": title,
       "des": des,
        "date": date, 
        "color": Colors.white
        },
    );
  }

  void deleteData(int index) {
    noteList.removeAt(index);
  }

 void colorSelection(Color newColor) {
    selectedColor = newColor;
  }

}
