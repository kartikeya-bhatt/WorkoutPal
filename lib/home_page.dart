import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'routine_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: blue,
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
            CustomButton("Monday"),
            CustomButton("Tuesday"),
            CustomButton("Wednesday"),
            CustomButton("Thursday"),
            CustomButton("Friday"),
            CustomButton("Saturday"),
            CustomButton("Sunday"),
          ]),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String day;
  CustomButton(this.day);

  @override
  _CustomButtonState createState() => _CustomButtonState(day);
}

class _CustomButtonState extends State<CustomButton> {
  final String day;
  bool isHeld = false;

  _CustomButtonState(this.day);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutinePage(day)),
          );
        },
        onTapDown: (TapDownDetails d) {
          setState(() {
            isHeld = true;
          });
        },
        onTapUp: (TapUpDetails d) {
          setState(() {
            isHeld = false;
          });
        },
        onTapCancel: () {
          setState(() {
            isHeld = false;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.055,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: yellow,
                width: isHeld ? 3.0 : 0.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: isHeld ? Offset(0, 0) : Offset(0, 3),
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
                  TextSpan(text: 'Pal', style: TextStyle(color: yellow))
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
