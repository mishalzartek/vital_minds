
import 'package:flutter/material.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: height * 0.2, bottom: height * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome to MyVitalMind",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 25.0),
                    textAlign: TextAlign.left),
                Text(
                  " ",
                  style: TextStyle(fontSize: 8),
                ),
                Text(" Prioritize your journey to well being",
                    style: TextStyle(
                        color: const Color(0xffffffff),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                    textAlign: TextAlign.left)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
