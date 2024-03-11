// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_import, unnecessary_string_interpolations, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

class CustomWidgets extends StatefulWidget {
  CustomWidgets({
    super.key,
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
  State<CustomWidgets> createState() => _CustomWidgetsState();
}

class _CustomWidgetsState extends State<CustomWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: widget.noteColor),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.edit), onPressed: widget.editButton),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.deleteButton,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.des),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.date),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share("${widget.title}\n" "${widget.des}");
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
