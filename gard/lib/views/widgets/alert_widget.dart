import 'package:flutter/material.dart';
import 'package:gard/views/widgets/buttons.dart';
import 'package:get/get.dart';

// showAlertDialog(BuildContext context, String text) {
//     // Create button
//     Widget okButton = CustomButton(onPressed: Get.back() ,text: 'OK',);
//     (
//       color: kbutton,
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );

//     // Create AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(""),
//       content: Text(
//         text,
//         style: TextStyle(fontSize: 30),
//       ),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }