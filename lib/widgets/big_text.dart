import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigText(
      {super.key,
      this.color = Colors.black,
      this.size = 20,
      required this.text,
      this.overFlow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        // fontFamily: 'Roberto',
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
