
import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/views/widgets/custom_Text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text,
   this.color=primaryColor, this.textColor=Colors.white, this.sizeBorder=50, this.height, this.width, });
final VoidCallback? onPressed;
final String text;
final Color color;
final Color textColor;
final double sizeBorder;
final double? height;
final double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(sizeBorder),
          border: Border.all(
            color: primaryColor,
          ),
        ),
        padding: EdgeInsets.all(18),
      child:Center(
        child:CustomText(text: text,alignment: Alignment.center,color: textColor,)
      )
      ),
 
    );
  }
}