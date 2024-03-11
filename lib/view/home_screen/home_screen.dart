// // ignore_for_file: prefer_const_constructors, dead_code

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:note_application/controller/home_screen_controller.dart';
// import 'package:note_application/utils/color_constants.dart';
// import 'package:note_application/view/home_screen/widgets/custom_bottomsheet.dart';
// import 'package:note_application/view/home_screen/widgets/custom_widgets.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// HomeScreenController homeScreenController = HomeScreenController();

// class _HomeScreenState extends State<HomeScreen> {
//   var myBox = Hive.box('note');

//   @override
//   void initState() {
//     homeScreenController.init();
//     setState(() {});
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.customColorBlack,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: ColorConstants.customColorPurple,
//         onPressed: () {
//           HomeScreenController.clearController();
//           showModalBottomSheet(
//               isScrollControlled: true,
//               context: context,
//               builder: (context) => CustomBottomSheet(
//                     onSavePressed: () {
//                       homeScreenController.addData();
//                       setState(() {});
//                       HomeScreenController.clearController();
//                       Navigator.pop(context);
//                     },
//                   ));
//         },
//         child: Icon(Icons.add),
//       ),
//       appBar: AppBar(
//         backgroundColor: ColorConstants.customColorBlack,
//         title: Text(
//           "Note App",
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 30,
//               color: ColorConstants.customColorWhite),
//         ),
//       ),
//       body: homeScreenController.noteKeys.isEmpty
//           ? Center(
//               child: Text(
//                 "No data found",
//                 style: TextStyle(color: ColorConstants.customColorWhite),
//               ),
//             )
//           : ListView.separated(
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 var element = myBox.get(homeScreenController.noteKeys[index]);
//                 return CustomWidgets(
//                   title: element["title"],
//                   des: element["des"],
//                   date: element["date"],
//                   noteColor: element["color"] != null
//                       ? HomeScreenController.customColorList[element["color"]]
//                       : Colors.white,
//                   deleteButton: () {
//                     homeScreenController
//                         .deleteData(homeScreenController.noteKeys[index]);
//                     setState(() {});
//                   },
//                   editButton: () {
//                     HomeScreenController.titleController.text =
//                         element["title"];
//                     HomeScreenController.desController.text = element["des"];
//                     HomeScreenController.dateController.text = element["date"];
//                     homeScreenController.colorSelection(element["color"]);
//                   },
//                 );
//                 showModalBottomSheet(
//                   isScrollControlled: true,
//                   context: context,
//                   builder: (context) => CustomBottomSheet(
//                     isEdit: true,
//                     onSavePressed: () {
//                       homeScreenController
//                           .editData(homeScreenController.noteKeys[index]);
//                       setState(() {});
//                       HomeScreenController.clearController();
//                       Navigator.pop(context);
//                     },
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => SizedBox(
//                     height: 20,
//                   ),
//               itemCount: homeScreenController.noteKeys.length),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/controller/home_screen_controller.dart';
import 'package:note_application/utils/color_constants.dart';
import 'package:note_application/view/home_screen/widgets/custom_bottomsheet.dart';
import 'package:note_application/view/home_screen/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = HomeScreenController();
  var myBox = Hive.box("note");

  @override
  void initState() {
    homeScreenController.init();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.customColorBlack,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.customColorPurple,
        onPressed: () {
          HomeScreenController.clearController();

          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => CustomBottomSheet(
                    onSavePressed: () {
                      // function to add a new note
                      homeScreenController.addData();
                      setState(() {});
                      HomeScreenController.clearController();

                      Navigator.pop(context);
                    },
                  ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstants.customColorBlack,
        centerTitle: true,
        title: Text("Note Pad"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.customColorWhite,
            fontSize: 28),
      ),
      body: homeScreenController.noteKeys.isEmpty
          ? Center(
              child: Text(
                "No data found",
                style: TextStyle(
                  color: ColorConstants.customColorWhite,
                ),
              ),
            )
          : ListView.separated(
              itemCount: homeScreenController.noteKeys.length,
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var element = myBox.get(homeScreenController.noteKeys[index]);
                return CustomWidgets(
                  title: element["title"],
                  date: element["date"],
                  des: element["des"],
                  noteColor: element["color"] != null
                      ? HomeScreenController.customColorList[element["color"]]
                      : Colors.white,
                  deleteButton: () {
                    // to delete a data from the list

                    homeScreenController
                        .deleteData(homeScreenController.noteKeys[index]);
                    setState(() {});
                  },
                  editButton: () {
                    //ASSIGNING VALUES TO CONTROLEERS WHILE EDITING
                    HomeScreenController.titleController.text =
                        element["title"];
                    HomeScreenController.desController.text = element["des"];
                    HomeScreenController.dateController.text = element["date"];

                    homeScreenController.colorSelection(element["color"]);
// bottom sheet to update a data
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => CustomBottomSheet(
                              isEdit: true,
                              onSavePressed: () {
                                // function to edit a note

                                homeScreenController.editData(
                                    homeScreenController.noteKeys[index]);
                                setState(() {});
                                HomeScreenController
                                    .clearController(); // CLEAR CONTROLLERS

                                Navigator.pop(context);
                              },
                            ));
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            ),
    );
  }
}
