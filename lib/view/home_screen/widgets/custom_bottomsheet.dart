// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:note_application/controller/home_screen_controller.dart';
import 'package:note_application/utils/color_constants.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({super.key, this.onSavePressed, this.isEdit = false});

  final void Function()? onSavePressed;
  final bool isEdit;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, bottomSetState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (HomeScreenController
                            .titleController.text.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a valid title";
                        }
                      },
                      controller: HomeScreenController.titleController,
                      decoration: InputDecoration(
                          label: Text("Title"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (HomeScreenController
                            .desController.text.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a valid description";
                        }
                      },
                      controller: HomeScreenController.desController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          label: Text("Description"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      readOnly: true,
                      validator: (value) {
                        if (HomeScreenController
                            .dateController.text.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a valid date";
                        }
                      },
                      controller: HomeScreenController.dateController,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025));
                              if (selectedDate != null) {
                                String formatedDate = DateFormat("dd/MM/yyyy")
                                    .format(selectedDate);

                                HomeScreenController.dateController.text =
                                    formatedDate;
                              }
                            },
                            child: Icon(Icons.calendar_month),
                          ),
                          label: Text("Date"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            HomeScreenController obj = HomeScreenController();
                            obj.colorSelection(index);
                            bottomSetState(
                              () {},
                            );
                           
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: HomeScreenController
                                            .selectedColorIndex ==
                                        index
                                    ? Border.all(width: 3, color: Colors.red)
                                    : null,
                                color: HomeScreenController
                                    .customColorList[index]),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              HomeScreenController.clearController();

                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstants.customColorPurple,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Center(child: Text("Cancel"))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                widget.onSavePressed!();
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstants.customColorPurple,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Center(
                                    child: Text(
                                        widget.isEdit ? "Update" : "Save"))),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
