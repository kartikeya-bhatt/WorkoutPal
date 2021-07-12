import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

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
                children: <Widget>[
                  Center(child: DayHeader(day)),
                  MyReorderableList(),

                ])));
  }
}

class DayHeader extends StatefulWidget {
  final String day;
  DayHeader(this.day);

  @override
  _DayHeaderState createState() => _DayHeaderState();
}

class _DayHeaderState extends State<DayHeader> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: widget.day,
                style: TextStyle(
                  fontSize: 50,
                  color: white,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            AutoSizeTextField(
                controller: TextEditingController(text: "Enter Workout Name"),
                maxLines: 1,
                minFontSize: 20,
                cursorColor: white,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                onChanged: (text) {
                  print(text);
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: white,
                  fontFamily: 'Ubuntu',
                ))
          ],
        ),
      ),
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
            WorkoutButton(),
            WorkoutButton(),
            WorkoutButton(),
            WorkoutButton()
          ]),
    );
  }
}

class WorkoutButton extends StatefulWidget {
  const WorkoutButton({
    Key key,
  }) : super(key: key);

  @override
  _WorkoutButtonState createState() => _WorkoutButtonState();
}

class _WorkoutButtonState extends State<WorkoutButton> {
  bool isHeld = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
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
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.09,
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
                    blurRadius: 4,
                    offset: isHeld ? Offset(0, 0) : Offset(0, 3),
                  )
                ]),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Column(children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: AutoSizeText("Assisted Pull Up",
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: blue,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: AutoSizeText("2 x 12 at 20 lbs.",
                      maxFontSize: 14,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: blue,
                        fontFamily: 'Ubuntu',
                      )),
                )
              ]),
            ),
          ),
        ));
  }
}

class MyReorderableList extends StatelessWidget {

  final List<int> _items = List<int>.generate(4, (int index) => index);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <WorkoutButton>[
          WorkoutButton(),
          WorkoutButton(),
          WorkoutButton(),
          WorkoutButton(),
          WorkoutButton(),
          WorkoutButton(),
          WorkoutButton()
        ],
      ),
    );
  }
}
