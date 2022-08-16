import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // for debugging purposes
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5,
          itemBuilder: (contect, position) {
            return _buildPageItem(position);
          }),
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(children: [
      Container(
        height: 220, //wil take the parent container if this line is in comment
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
            image: DecorationImage(
              image: AssetImage("assets/image/food0.png"),
              fit: BoxFit.cover,
            )),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height:
              140, //wil take the parent container if this line is in comment
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
        ),
      )
    ]);
  }
}
