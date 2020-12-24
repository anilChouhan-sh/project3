import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskarta/Firebase/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formlogin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            RaisedButton(
                color: Colors.teal[700],
                onPressed: () async {
                  if (_formlogin.currentState.validate()) {
                    String x = await auth.signIn(username.text, password.text);
                    if (FirebaseAuth.instance.currentUser.emailVerified) {
                      Navigator.pushNamed(context, '/');
                    } else {
                      myToast('Email Not verified.');
                    }
                    //  await auth.currentUser(context);
                    print('haa bhai');
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
