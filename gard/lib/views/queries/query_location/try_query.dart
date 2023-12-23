// import 'package:flutter/material.dart';
// import 'package:gard/constants.dart';
// import 'package:gard/core/viewModel/try_query.dart';
// import 'package:gard/views/widgets/bar_widget.dart';
// import 'package:gard/views/widgets/custom_Text.dart';
// import 'package:get/get.dart';

// class TryQueryView extends StatelessWidget {
//   TryQueryView({this.email});
//   String? email;
  
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<TryQuery>(
//       init:  Get.find<TryQuery>(),
//       builder: (TryQuery controller) => controller.loading.value
//           ? Scaffold(
//             backgroundColor: Colors.white,
//             body: Center(child: CircularProgressIndicator(color:primaryColor,)))
//           : Scaffold(
//             backgroundColor: Colors.white,
//               appBar: AppBar(
//                 automaticallyImplyLeading: false,
//                 title: Row(
//                   children: [
//                     Icon(Icons.groups, size: 35, color: primaryColor),
//                     SizedBox(width: 20),
//                     CustomText(
//                       text: email??'',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22,
//                     ),
//                   ],
//                 ),
//               ),
//               body: Stack(
//                 children: [
                  
//                   barWidget(text: 'المواقع',
//                    onTap: () {
//                             Get.back();
//                           },),
//                    Padding(
//                     padding: const EdgeInsets.only(top: 60),
//                     child: Expanded(
//                       child: GetBuilder<TryQuery>(
//                         builder: (controller) {
//                           return ListView.builder(
//                             itemCount: controller.locationModel.length + 1,
//                             itemBuilder: (context, index) {
//                               if (index == 0) {
//                                 // إنشاء صف الأعمدة
//                                 return Container(
//                                   child: Table(
//                                     children: [
//                                       TableRow(
//                                         decoration: BoxDecoration(
//                                           color: Color.fromARGB(
//                                               255, 137, 207, 190),
//                                         ),
//                                         children: [
//                                           Container(
//                                             height: 50,
//                                             child: Center(
//                                               child: TableCell(
//                                                 child: Text('الرقم'),
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 50,
//                                             child: Center(
//                                               child: TableCell(
//                                                 child: Text('الاسم'),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 );
                             
//                               } else {
//                                 // إنشاء صفوف البيانات
//                                 final dataIndex = index - 1;
//                                 return Padding(
//                                   padding: const EdgeInsets.all(7.0),
//                                   child: Container(
//                                     child: Table(
//                                       children: [
//                                         TableRow(
//                                           children: [
//                                             Container(
//                                               child: Center(
//                                                 child: TableCell(
//                                                   child: CustomText(
//                                                     text: controller.locationModel[dataIndex].barcode!,
//                                                     fontSize: 20,),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               child: Center(
//                                                 child: TableCell(
//                                                   child: CustomText(
//                                                     text:controller.locationModel[dataIndex].locName!,
//                                                     fontSize: 20,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
                             
//                               }
//                             },
//                           );
                       
//                         },
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }
