// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_field, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note_application/controller/home_screen_controller.dart';
import 'package:note_application/view/home_screen/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var myBox = Hive.box("note");

  @override
  void initState() {
    homeScreenController.init();
    setState(() {});
    super.initState();
  }

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

  static int selectedColorIndex = 0;

  var formKey = GlobalKey<FormState>();

  void editData(var key) {
    myBox.put(key, {
      "title": titleController.text,
      "des": desController.text,
      "date": dateController.text,
      "color": selectedColorIndex,
    });
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
                // clearController();
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
                                readOnly: true,
                                validator: (value) {
                                  if (dateController.text.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Enter a Valid date";
                                  }
                                },
                                controller: dateController,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: () async {
                                        final DateTime? selectedDate =
                                            await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2025));
                                        if (selectedDate != null) {
                                          String formatedDate =
                                              DateFormat("dd/MM/yyyy")
                                                  .format(selectedDate);

                                          dateController.text = formatedDate;
                                        }
                                      },
                                      child: Icon(Icons.calendar_month)),
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
                                height: 60,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      selectedColorIndex = index;

                                      bottomSetState(() {});
                                    },
                                    child: Container(
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: customColorList[index],
                                        border: selectedColorIndex == index
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
                                                selectedColorIndex);

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
      body: homeScreenController.noteKeys.isEmpty
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
                    title: myBox
                        .get(homeScreenController.noteKeys[index])["title"],
                    des: myBox.get(homeScreenController.noteKeys[index])["des"],
                    date:
                        myBox.get(homeScreenController.noteKeys[index])["date"],
                    noteColor: [
                              myBox.get(homeScreenController.noteKeys[index])
                            ] !=
                            null
                        ? customColorList[
                            myBox.get(homeScreenController.noteKeys[index])]
                        : Colors.white,
                    deleteButton: () {
                      homeScreenController
                          .deleteData(homeScreenController.noteKeys[index]);
                      setState(() {});
                    },
                    editButton: () {
                      titleController.text = myBox
                          .get(homeScreenController.noteKeys[index])["title"];

                      desController.text = myBox
                          .get(homeScreenController.noteKeys[index])["des"];

                      dateController.text = myBox
                          .get(homeScreenController.noteKeys[index])["date"];

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
                                            readOnly: true,
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
                                              suffixIcon: InkWell(
                                                  onTap: () async {
                                                    final DateTime?
                                                        selectedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2025));
                                                    if (selectedDate != null) {
                                                      String formatedDate =
                                                          DateFormat(
                                                                  "dd/MM/yyy")
                                                              .format(
                                                                  selectedDate);
                                                      dateController.text =
                                                          formatedDate;
                                                    }
                                                  },
                                                  child: Icon(
                                                      Icons.calendar_month)),
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
                                            height: 60,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: 4,
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                onTap: () {
                                                  selectedIndex = index;
                                                  selectedColorIndex =
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
                                                      editData(
                                                          homeScreenController
                                                              .noteKeys[index]);
                                                      // bottomSetState(
                                                      //   () {},
                                                      // );

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
              itemCount: homeScreenController.noteKeys.length),
    );
  }
}
