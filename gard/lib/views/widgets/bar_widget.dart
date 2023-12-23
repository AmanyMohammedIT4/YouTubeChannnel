import 'package:flutter/material.dart';
import 'package:gard/constants.dart';
import 'package:gard/views/widgets/custom_Text.dart';

class barWidget extends StatelessWidget {
  const barWidget({super.key, required this.text, required this.onTap});
final String text;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: text,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        GestureDetector(
                          onTap:onTap,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    tileColor: primaryColor,
                  );
  }
}