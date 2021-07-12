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
                children: <Widget>[Center(child: DayHeader(day)), Spacer()])));
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
  String _save_text;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    bool isDefault = _save_text == null;
    return Container(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: widget.day,
              style: TextStyle(
                fontSize: 60,
                color: white,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
          AutoSizeTextField(
              controller: isDefault ? TextEditingController(text: "Enter Workout Name") : TextEditingController(text: _save_text),
              maxLines: 1,
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
                _save_text = text;
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
    );
  }
}

