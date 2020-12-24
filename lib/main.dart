import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

import 'package:taskarta/Firebase/users.dart';

import 'package:taskarta/home.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/rounded_button.dart';

import 'Firebase/auth.dart';
import 'Firebase/entryprovider.dart';
import 'Login/Login.dart';
import 'Login/signup.dart';
import 'package:taskarta/Firebase/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginScrn());
}

class LoginScrn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> f = new GlobalKey();
    return ChangeNotifierProvider(
      create: (context) => Entryprovider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => mainscreen(),
            '/signup': (context) => SignupScreen(),
            '/login': (context) => LoginScreen(),
            '/tasks': (context) => Mytask(
                userid: FirebaseAuth.instance.currentUser.uid,
                name: FirebaseAuth.instance.currentUser.email)
          }),
    );
  }
}

class mainscreen extends StatefulWidget {
  const mainscreen({
    Key key,
  }) : super(key: key);

  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  User user = FirebaseAuth.instance.currentUser;
  Auth auth = new Auth();
  GlobalKey<FormState> _formlogin = new GlobalKey<FormState>();
  var username = new TextEditingController();
  var password = new TextEditingController();
  var name = new TextEditingController();
  myToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);
    List<dynamic> displayname = [
      FirebaseAuth.instance.currentUser.uid.toString()
    ];
    entryProvider.changeusername = displayname;
    if (user == null) {
      return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal[700],
            title: Text(
              'TasKarta',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: Form(
              key: _formlogin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "WELCOME TO EDU ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: username,
                      cursorColor: Colors.teal[700],
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.teal[700],
                        ),
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: password,
                      cursorColor: Colors.teal[700],
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Colors.teal[700],
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Colors.teal[700],
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () async {
                      if (_formlogin.currentState.validate()) {
                        String x =
                            await auth.signIn(username.text, password.text);
                        if (FirebaseAuth.instance.currentUser.emailVerified) {
                          Navigator.pushNamed(context, '/');
                        } else {
                          myToast('Email Not verified.');
                        }
                        //  await auth.currentUser(context);
                        print('haa bhai');
                      }
                    },
                  ),
                  RoundedButton(
                    text: "SIGN UP",
                    color: Colors.teal[100],
                    textColor: Colors.black,
                    press: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      var p = user.email;
      return StreamBuilder<List<Users>>(
          stream: entryProvider.users,
          builder: (context, snapshot) {
            return Mytask(
                userid: FirebaseAuth.instance.currentUser.uid,
                name: snapshot.data[0].name);
          });
    }
  }
}
