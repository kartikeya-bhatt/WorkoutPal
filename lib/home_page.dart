import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Color color;

  HomePage(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton("monday"),
              CustomButton("tuesday"),
              CustomButton("wednesday"),
              CustomButton("thursday"),
              CustomButton("friday"),
              CustomButton("saturday"),
              CustomButton("sunday"),
            ]));
  }
}

class CustomButton extends StatelessWidget {
  final String day;
  CustomButton(this.day);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(

        onTap: () {
          final snackBar = SnackBar(content: Text("Hello"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.05,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]),
          child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Ubuntu',
                  ))),
        ),
      ),
    );
  }
}
