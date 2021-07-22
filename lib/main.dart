import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/login_page.dart';
import 'User.dart';
import 'nav_bar.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
      ChangeNotifierProvider<AuthService>(
        child: MyApp(),
        create: (BuildContext context) {
          return AuthService();
        },
      ),
    );

class AuthService with ChangeNotifier {
  User currentUser;

  AuthService() {
    currentUser = null;
    print("new AuthService");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  // wrapping the firebase calls
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  // wrapping the firebase calls
  Future createUser({String name, String password}) async {}

  // logs in the user if password matches
  Future loginUser(String name, String password) async {
    var url = Uri.parse('http://10.0.2.2:8080/login');
    final response = await http.post(
      url,
      body: json.encode({'username': name, 'password': password}),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    currentUser = User.fromJson(jsonDecode(response.body));
    notifyListeners();
    return response;

/*    if (password == 'password') {
      this.currentUser = {'name': name};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }*/
  }
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: blue),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData ? Home(snapshot.data) : CreateAccount();
          } else {
            return LoadingCircle();
          }
        },
      ),
    );
  }
}
class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}

