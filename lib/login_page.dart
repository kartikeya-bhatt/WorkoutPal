import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


class CreateAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            child: Text(
                'Hi',
              style: TextStyle(
                color: white,
                fontFamily: 'Ubuntu',
                fontSize: 30
              )
            ),
          ),
        ],
      ),
    );
  }
}
