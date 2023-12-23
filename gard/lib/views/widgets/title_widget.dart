import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/views/widgets/custom_Text.dart';

class TitleWidget extends StatelessWidget {
   TitleWidget({super.key,required this.name});
String name;

  @override
  Widget build(BuildContext context) {
    return  Row(
              children: [
                Icon(Icons.groups,size: 35,color: primaryColor,),
                SizedBox(width: 20,),
                CustomText(text: name,fontWeight: FontWeight.bold,fontSize: 22,),
              ],
            );
  }
}