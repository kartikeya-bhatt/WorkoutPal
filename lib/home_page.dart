import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class HomePage extends StatelessWidget {
  final Color color;

  HomePage(this.color);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: color,
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Center(child: Header()),
                Spacer(),
                Center(child: ButtonGroup()),
                Spacer()
              ])),
    );
  }
}

class ButtonGroup extends StatefulWidget {
  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          ]),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String day;
  CustomButton(this.day);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          final snackBar = SnackBar(content: Text("Hello"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        onLongPress: () {
          decoration:
          BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.055,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: white,
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
              child: Text(widget.day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blue,
                    fontFamily: 'Ubuntu',
                  ))),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Workout',
                style: TextStyle(
                  fontSize: 60,
                  color: white,
                  fontFamily: 'Ubuntu',
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Pal', style: TextStyle(color: yellow))
                ]),
          ),
          Text("record your workouts...",
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
