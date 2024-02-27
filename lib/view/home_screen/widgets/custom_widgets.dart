// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:note_application/controller/home_screen_controller.dart';

class CustomWidgets extends StatelessWidget {
   CustomWidgets(
      {super.key,
      required this.title,
      required this.des,
      required this.date,
      required this.noteColor,
      this.deleteButton,
      this.editButton,
      
      });

  final String title;
  final String des;
  final String date;
  final Color noteColor;
 

  final void Function()? deleteButton;
  final void Function()? editButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: noteColor),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Icons.edit), onPressed: editButton),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: deleteButton,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(des),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(date),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.share)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
