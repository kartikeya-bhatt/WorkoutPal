import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';
import 'package:frontend/routine_page.dart';
import 'package:frontend/make_account.dart';
import 'User.dart';
import 'constants.dart';

class CreateAccount extends StatelessWidget {

  List<Day> days = [];
  final List<String> dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  User myUser;

  CreateAccount () {
    for(String name in dayNames) {
      List<Exercise> exercises = [];
      days.add(new Day(name, exercises));
    }

    myUser = new User("", "", days);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: Header()),
                  SizedBox(height: h * 0.07),
                  Container(
                      alignment: Alignment.centerLeft,
                      constraints: BoxConstraints.tightFor(
                          width: w * 0.875, height: h * 0.025),
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(height: h * 0.01),
                  Container(
                    constraints: BoxConstraints.tightFor(
                        width: w * 0.9, height: h * 0.075),
                    decoration: BoxDecoration(
                      color: Color(0xFF6CA8F1),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 16),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.025),
                  Container(
                      alignment: Alignment.centerLeft,
                      constraints: BoxConstraints.tightFor(
                          width: w * 0.875, height: h * 0.025),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(height: h * 0.01),
                  Container(
                    constraints: BoxConstraints.tightFor(
                        width: w * 0.9, height: h * 0.075),
                    decoration: BoxDecoration(
                      color: Color(0xFF6CA8F1),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 17),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * .025),
                  Container(
                    child: Text(
                      'Error: Username and Password do not match',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFFE57373),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.05),
                  Container(
                    constraints: BoxConstraints.tightFor(
                        width: w * 0.6, height: h * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(myUser)),
                        );
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.6,
                          color: Color(0xFF478DE0),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: white, // background
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.035),
                  Container(
                    child: Text(
                      '- OR -',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.035),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MakeAccount()),
                      );
                    },
                    child: Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'OpenSans',
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
          )),
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
                  fontFamily: 'OpenSans',
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
                fontFamily: 'OpenSans',
              ))
        ],
      ),
    );
  }
}
