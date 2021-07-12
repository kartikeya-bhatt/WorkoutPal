import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class RoutinePage extends StatelessWidget {
  final String day;
  RoutinePage(this.day);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: blue,
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Center(child: DayHeader(day)), Spacer()])));
  }
}

class DayHeader extends StatelessWidget {
  final String day;
  DayHeader(this.day);

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: day,
              style: TextStyle(
                fontSize: 60,
                color: white,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
          Text("Push Day",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: white,
                fontFamily: 'Ubuntu',
              ))
        ],
      ),
    );
  }
}
