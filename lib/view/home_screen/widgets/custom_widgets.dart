// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomWidgets extends StatefulWidget {
  const CustomWidgets({super.key});

  @override
  State<CustomWidgets> createState() => _CustomWidgetsState();
}

class _CustomWidgetsState extends State<CustomWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 243, 240, 209)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Title",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  Icon(Icons.edit),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.delete)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Ahghgjfhf"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Tue, Feb 20, 2024"),
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
