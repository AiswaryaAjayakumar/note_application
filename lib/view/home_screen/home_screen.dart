// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_field, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:note_application/controller/home_screen_controller.dart';
import 'package:note_application/view/home_screen/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = HomeScreenController();

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void clearController() {
    titleController.clear();
    desController.clear();
    dateController.clear();
  }

  int selectedIndex = 0;

  List customColorList = [
    const Color.fromARGB(255, 240, 201, 198),
    const Color.fromARGB(255, 208, 239, 209),
    const Color.fromARGB(255, 186, 211, 231),
    Color.fromARGB(255, 231, 224, 165)
  ];

  static Color selectedColor = Colors.white;

  var formKey = GlobalKey<FormState>();

  void editData(int index) {
    homeScreenController.noteList[index] = {
      "title": titleController.text,
      "des": desController.text,
      "daste": dateController.text,
      "color": selectedColor
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, bottomSetState) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(28)),
                        color: Color.fromARGB(255, 80, 79, 79),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (titleController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Enter a Valid date";
                                  }
                                },
                                controller: titleController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 174, 172, 172),
                                  label: Text("Title"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  //fillColor: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (desController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Enter a Valid date";
                                  }
                                },
                                controller: desController,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 174, 172, 172),
                                  label: Text("Description"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (dateController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Enter a Valid date";
                                  }
                                },
                                controller: dateController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 174, 172, 172),
                                  label: Text("Date"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      selectedIndex = index;
                                      selectedColor =
                                          customColorList[selectedIndex];
                                      bottomSetState(() {});
                                    },
                                    child: Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: customColorList[index],
                                        border: selectedIndex == index
                                            ? Border.all(color: Colors.red)
                                            : null,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          clearController();
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          child: Center(child: Text("Cancel")),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            homeScreenController.addData(
                                                titleController.text,
                                                desController.text,
                                                dateController.text,
                                                selectedColor);

                                            setState(() {});
                                            clearController();
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Container(
                                          height: 30,
                                          child: Center(child: Text("Save")),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "NOTE PAD",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: homeScreenController.noteList.isEmpty
          ? Center(
              child: Text(
              "No data found",
              style: TextStyle(
                color: Colors.white,
              ),
            ))
          : ListView.separated(
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) => CustomWidgets(
                    title: homeScreenController.noteList[index]["title"],
                    des: homeScreenController.noteList[index]["des"],
                    date: homeScreenController.noteList[index]["date"],
                    noteColor: homeScreenController.noteList[index]["color"],
                    deleteButton: () {
                      homeScreenController.deleteData(index);
                      setState(() {});
                    },
                    editButton: () {
                      titleController.text =
                          homeScreenController.noteList[index]["title"];
                      desController.text =
                          homeScreenController.noteList[index]["des"];
                      dateController.text =
                          homeScreenController.noteList[index]["date"];
                      selectedColor;

                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, bottomSetState) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(28)),
                                    color: Color.fromARGB(255, 80, 79, 79),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            validator: (value) {
                                              if (titleController
                                                  .text.isNotEmpty) {
                                                return null;
                                              } else {
                                                return "Enter a Valid date";
                                              }
                                            },
                                            controller: titleController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 174, 172, 172),
                                              label: Text("Title"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              //fillColor: Colors.white
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (desController
                                                  .text.isNotEmpty) {
                                                return null;
                                              } else {
                                                return "Enter a Valid date";
                                              }
                                            },
                                            controller: desController,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 174, 172, 172),
                                              label: Text("Description"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (dateController
                                                  .text.isNotEmpty) {
                                                return null;
                                              } else {
                                                return "Enter a valid date";
                                              }
                                            },
                                            controller: dateController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 174, 172, 172),
                                              label: Text("Date"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                onTap: () {
                                                  selectedIndex = index;
                                                  selectedColor =
                                                      customColorList[
                                                          selectedIndex];
                                                  bottomSetState(() {});
                                                },
                                                child: Container(
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        customColorList[index],
                                                    border: selectedIndex ==
                                                            index
                                                        ? Border.all(
                                                            color: Colors.red)
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 10,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      clearController();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      child: Center(
                                                          child:
                                                              Text("Cancel")),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      editData(index);

                                                      setState(() {});
                                                      clearController();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      child: Center(
                                                          child:
                                                              Text("Update")),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: homeScreenController.noteList.length),
    );
  }
}
