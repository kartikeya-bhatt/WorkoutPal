import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';
import 'package:frontend/routine_page.dart';
import 'package:frontend/make_account.dart';
import 'User.dart';
import 'constants.dart';
import 'login_page.dart';
import 'nav_bar.dart';

class ProfilePage extends StatelessWidget {

  User myUser;
  ProfilePage (this.myUser) {
    print(myUser.username);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                SizedBox(height: h * 0.05),
                Text('Currently Signed in as: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(myUser.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w400,
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
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateAccount("")),
                      );
                    },
                    child: Text(
                      'LOG OUT',
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

              ],
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
