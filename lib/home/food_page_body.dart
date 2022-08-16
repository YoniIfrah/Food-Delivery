// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';
import 'dart:math';

import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/icon_and_text.dart';
import 'package:app/widgets/small_text.dart';
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
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        //print("current value: " + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red, // for debugging purposes
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
    int rate =
        Random().nextInt(5) + 1; // generate random number between 1 and 5

    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      // refer to the currect slide - center
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      // refer to the next slide - right side
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      // refer to the next slide - left side
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        Container(
          height:
              220, //wil take the parent container if this line is in comment
          margin: EdgeInsets.only(left: 10, right: 10),
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
                120, //wil take the parent container if this line is in comment
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ]),
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Sushi"),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Wrap(
                            children: List.generate(
                                rate,
                                (index) => Icon(Icons.star,
                                    color: Colors.blue,
                                    size: 15))), // draw the starts
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: rate.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(
                            text: generateRandInt(5001, str: "comments")
                                .toString()),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "comments")
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(children: [
                      IconAndTextWidget(
                        icon: Icons.circle_sharp,
                        text: "Normal",
                        iconColor: Colors.yellow,
                      ),
                      IconAndTextWidget(
                        icon: Icons.location_on,
                        text: generateRandDouble(10).toStringAsFixed(1) + "km",
                        iconColor: Colors.blue,
                      ),
                      IconAndTextWidget(
                        icon: Icons.access_time_rounded,
                        text: generateRandInt(60, min: 15).toString() + "min",
                        iconColor: Colors.red,
                      ),
                    ]),
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}

int generateRandInt(int max, {int min = 1, String str = ""}) {
  int num = Random().nextInt(max) + min;
  if (str == "comments") {
    return num;
  }
  return num < 60 ? num : 60;
}

double generateRandDouble(int max) {
  return Random().nextDouble() * (max - 1) + 1;
}
