import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'User.dart';
import 'package:http/http.dart' as http;

StreamController<int> streamController = StreamController<int>.broadcast();

class RoutinePage extends StatefulWidget {
  final String username;
  final Day day;
  final Stream<int> stream;


  RoutinePage(this.username, this.day, this.stream);

  List<Exercise> getList() {
    return day.exercises;
  }

  @override
  _RoutinePageState createState() => _RoutinePageState(getList());
}

class _RoutinePageState extends State<RoutinePage> {
  final List<Exercise> list;
  _RoutinePageState(this.list);

  void mySetState() {
    if (!this.mounted) return;
    setState(() {
      list.add(
        new Exercise("Empty Workout", 0, 0, 0),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    widget.stream.listen((index) {
      mySetState();
    });
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
                  Center(child: DayHeader(widget.username, widget.day)),
                  MyReorderableList(widget.username, widget.day.dayName, list),
                  AddButton(widget.username, widget.day.dayName),
                ])));
  }
}

class DayHeader extends StatefulWidget {
  final String username;
  final Day day;
  DayHeader(this.username, this.day);

  @override
  _DayHeaderState createState() => _DayHeaderState(day);
}

class _DayHeaderState extends State<DayHeader> {

  List<String> list;
  String dayName;
  String workoutName;

  TextEditingController textFieldController;

  final Day day;
  _DayHeaderState(this.day) {


    dayName = day.dayName;
    workoutName = day.workoutName;

    textFieldController =
    TextEditingController(text: workoutName);
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
                text: dayName,
                style: TextStyle(
                  fontSize: 50,
                  color: white,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            AutoSizeTextField(
                controller: TextEditingController(text: workoutName),
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
                  workoutName = text;
                  day.setWorkoutName(text);
                  var url = Uri.parse('http://10.0.2.2:8080/edit/workoutName');
                  http.post(
                    url,
                    body: json.encode({'username': widget.username, 'dayName': widget.day.dayName, 'workoutName': workoutName}),
                    headers: {
                      "content-type": "application/json",
                      "accept": "application/json",
                    },
                  );
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

class MyReorderableList extends StatefulWidget {
  final String username;
  final String dayName;
  final List<Exercise> list;
  MyReorderableList(this.username, this.dayName, this.list);

  @override
  _MyReorderableListState createState() => _MyReorderableListState(list);
}

class _MyReorderableListState extends State<MyReorderableList> {

  final List<Exercise> list;
  _MyReorderableListState(this.list);


  Future<void> _displayTextInputDialog(BuildContext context, int index) async {
    String name = list[index].name;
    int reps = list[index].reps;
    int sets = list[index].sets;
    int weight = list[index].weight;

    TextEditingController _textFieldControllerName =
    TextEditingController(text: name);
    TextEditingController _textFieldControllerRep =
    TextEditingController(text: reps.toString());
    TextEditingController _textFieldControllerSet =
    TextEditingController(text: sets.toString());
    TextEditingController _textFieldControllerWeight =
    TextEditingController(text: weight.toString());

    bool isChanged = false;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(20)],
              controller: _textFieldControllerName,
              onChanged: (value) {
                setState(() {
                  name = value.trim();
                  isChanged = true;
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
              height: MediaQuery.of(context).size.height * 0.25,
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
                              sets = int.parse(value);
                              isChanged = true;
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
                              reps = int.parse(value);
                              isChanged = true;
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
                              weight = int.parse(value);
                              isChanged = true;
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
                    if(isChanged) {
                      list[index] = new Exercise(name, reps, sets, weight);
                    }
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
            final Exercise item = list.removeAt(oldIndex);
            list.insert(newIndex, item);
          });
        },
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              setState(() {
                var url = Uri.parse('http://10.0.2.2:8080/remove/exercise');
                http.delete(
                  url,
                  body: json.encode({'username': widget.username, 'dayName': widget.dayName, 'index': index}),
                  headers: {
                    "content-type": "application/json",
                    "accept": "application/json",
                  },
                );
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
                    title: Text(list[index].name,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 26,
                          color: blue,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(list[index].sets.toString() + " x " + list[index].reps.toString() + " at " + list[index].weight.toString() + " lbs.",
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
  final String username;
  final String dayName;
  AddButton(this.username, this.dayName);
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
            var url = Uri.parse('http://10.0.2.2:8080/add/exercise');
            http.put(
              url,
              body: json.encode({'username': widget.username, 'dayName': widget.dayName}),
              headers: {
                "content-type": "application/json",
                "accept": "application/json",
              },
            );
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
