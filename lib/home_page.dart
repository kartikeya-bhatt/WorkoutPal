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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF73AEF5),
                  Color(0xFF61A4F1),
                  Color(0xFF478DE0),
                  Color(0xFF398AE5),
                ],
              )),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Center(child: Header()),
                Spacer(),
                Center(child: ButtonGroup(days, myUser.username)),
                Spacer()
              ])),
    );
  }
}

class ButtonGroup extends StatefulWidget {
  final List<Day> days;
  final String username;
  ButtonGroup(this.days, this.username);

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
            CustomButton(widget.days[0], widget.username),
            CustomButton(widget.days[1], widget.username),
            CustomButton(widget.days[2], widget.username),
            CustomButton(widget.days[3], widget.username),
            CustomButton(widget.days[4], widget.username),
            CustomButton(widget.days[5], widget.username),
            CustomButton(widget.days[6], widget.username),
          ]),
    );
  }
}

class CustomButton extends StatefulWidget {
  final Day day;
  String username;
  CustomButton(this.day, this.username);

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
            MaterialPageRoute(builder: (context) => RoutinePage(widget.username, day, streamController.stream)),
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
            color: Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
            color: isHeld ? white : Color(0xFF6CA8F1),
            width: isHeld ? 2.0 : 0.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
                child: Text(day.dayName.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'OpenSans',
                      letterSpacing: 1.6,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
