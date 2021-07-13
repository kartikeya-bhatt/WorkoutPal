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
                  AddButton()
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

class ButtonGroup {
  static List<WorkoutButton> getButtons() {
    return [
      WorkoutButton(),
      WorkoutButton(),
      WorkoutButton(),
      WorkoutButton(),
      WorkoutButton(),
      WorkoutButton()
    ];
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
          child: Center(
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
              child: SizedBox(
                //fit: BoxFit.fitHeight,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text("Assisted Pull Up",
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 28,
                            color: blue,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text("2 x 12 at 20 lbs.",
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            color: blue,
                            fontFamily: 'Ubuntu',
                          )),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}

class MyReorderableList extends StatefulWidget {
  @override
  _MyReorderableListState createState() => _MyReorderableListState();
}

class _MyReorderableListState extends State<MyReorderableList> {
  final List<WorkoutButton> buttons = ButtonGroup.getButtons();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: buttons.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          onDismissed: (DismissDirection direction) {
            setState(() {
              buttons.removeAt(index);
            });
          },
          secondaryBackground: Container(),
          background: Container(),
          child: buttons[index],
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
        );
      },
    ));
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
          child: Icon(
        Icons.add_circle_outline,
        color: yellow,
        size: 45.0,
      )),
    );
  }
}
