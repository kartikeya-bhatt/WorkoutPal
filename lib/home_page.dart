import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/User.dart';
import 'constants.dart';
import 'routine_page.dart';

class HomePage extends StatelessWidget {

  User myUser;
  List<Day> days;
  HomePage(this.myUser) {
    days = myUser.days;
  }

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
                Center(child: ButtonGroup(days)),
                Spacer()
              ])),
    );
  }
}

class ButtonGroup extends StatefulWidget {
  final List<Day> days;
  ButtonGroup(this.days);

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
            CustomButton(widget.days[0]),
            CustomButton(widget.days[1]),
            CustomButton(widget.days[2]),
            CustomButton(widget.days[3]),
            CustomButton(widget.days[4]),
            CustomButton(widget.days[5]),
            CustomButton(widget.days[6]),
          ]),
    );
  }
}

class CustomButton extends StatefulWidget {
  final Day day;
  CustomButton(this.day);

  @override
  _CustomButtonState createState() => _CustomButtonState(day);
}

class _CustomButtonState extends State<CustomButton> {
  final Day day;
  _CustomButtonState(this.day);

  bool isHeld = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutinePage(day, streamController.stream)),
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
              child: Text(day.dayName,
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
