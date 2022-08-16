import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;

  //TextOverflow overFlow;

  SmallText({
    super.key,
    this.color = Colors.grey,
    this.size = 12,
    this.height = 1.2,
    required this.text,

    //this.overFlow = TextOverflow.ellipsis
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      //overflow: overFlow,
      style: TextStyle(
        color: color,
        // fontFamily: 'Roberto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
