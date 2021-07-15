import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

class RoutinePage extends StatefulWidget {
  final String day;
  final Stream<int> stream;

  RoutinePage(this.day, this.stream);

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  void mySetState() {
    if (!this.mounted) return;
    setState(() {
      list.add("Assisted Pull Up");
    });
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState();
    });
  }

  static List<String> list = [
    "Bench Press",
    "Overhead Press",
    "Chest Flies",
    "Hamstring Curl"
  ];

  static List<String> getList() {
    return list;
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
                  Center(child: DayHeader(widget.day)),
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
  String name = "Enter Workout Name";
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
                controller: TextEditingController(text: name),
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
                  name = text;
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

class WorkoutButton extends StatefulWidget {
  @override
  _WorkoutButtonState createState() => _WorkoutButtonState();
}

class _WorkoutButtonState extends State<WorkoutButton> {
  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('TextField in Dialog'),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    print(value);
                  });
                },
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Text Field in Dialog"),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: blue,
                  ),
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ListTile(
          title: Text("Assisted Pull Up",
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                fontSize: 26,
                color: blue,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text("2 x 12 at 20 lbs.",
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20,
                color: blue,
                fontFamily: 'Ubuntu',
              )),
          // trailing: GestureDetector(
          //   onTapDown: (TapDownDetails d) {
          //       _displayTextInputDialog(context);
          //   },
          trailing: Icon(
            Icons.drag_handle,
            size: 30,
          ),
          // ),
        ),
      ),
    );
  }
}

class MyReorderableList extends StatefulWidget {
  @override
  _MyReorderableListState createState() => _MyReorderableListState();
}

class _MyReorderableListState extends State<MyReorderableList> {

  final List<String> list = _RoutinePageState.getList();
  TextEditingController _textFieldControllerRep =
      TextEditingController(text: "0");
  TextEditingController _textFieldControllerSet =
      TextEditingController(text: "0");
  TextEditingController _textFieldControllerWeight =
      TextEditingController(text: "0");
  TextEditingController _textFieldControllerName =
      TextEditingController(text: "Enter Workout Name");
  String name;


  Future<void> _displayTextInputDialog(BuildContext context, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
              controller: _textFieldControllerName,
              onChanged: (value) {
                setState(() {
                  name = value;
                  print(value);
                });
              },
              decoration: InputDecoration(
                counterText: '',
                counterStyle: TextStyle(fontSize: 0),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 24  ,
                fontFamily: 'Ubuntu',
              ),
              textAlign: TextAlign.center,
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Sets:',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          )),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3)],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          ),
                          onChanged: (value) {
                            setState(() {
                              print(value);
                            });
                          },
                          controller: _textFieldControllerSet,
                          decoration: InputDecoration(
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Reps:',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          )),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3)],
                          maxLength: 3,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.end,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                            });
                          },
                          controller: _textFieldControllerRep,
                          decoration: InputDecoration(
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Weight:',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          )),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3)],
                          maxLength: 3,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Ubuntu',
                          ),
                          textAlign: TextAlign.end,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                            });
                          },
                          controller: _textFieldControllerWeight,
                          decoration: InputDecoration(
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('ACCEPT'),
                onPressed: () {
                  setState(() {
                    if(name != null)
                      list[index] = name;
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final String item = list.removeAt(oldIndex);
            list.insert(newIndex, item);
          });
        },
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              setState(() {
                list.removeAt(index);
              });
            },
            secondaryBackground: Container(),
            background: Container(),
            child: GestureDetector(
              onTap: () {
                _displayTextInputDialog(context, index);
              },
              child: (Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: ListTile(
                    title: Text(list[index],
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 26,
                          color: blue,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text("2 x 12 at 20 lbs.",
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: blue,
                          fontFamily: 'Ubuntu',
                        )),
                    trailing: !mounted
                        ? Icon(
                            Icons.drag_handle,
                            size: 30,
                          )
                        : ReorderableDragStartListener(
                            index: index,
                            child: Icon(
                              Icons.drag_handle,
                              size: 30,
                            ),
                          ),
                    // ),
                  ),
                ),
              )),
            ),
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
          );
        },
      ),
    ));
  }
}

class AddButton extends StatefulWidget {
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool isHeld = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            streamController.add(1);
          });
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
            child: Icon(
          Icons.add_circle_outline,
          color: isHeld ? yellow : white,
          size: 45.0,
        )),
      ),
    );
  }
}
