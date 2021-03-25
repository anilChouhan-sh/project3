import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:taskarta/Firebase/Providers/projectProvider.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';

import 'package:taskarta/Firebase/users.dart';
import 'package:taskarta/bottomnav.dart';

import 'package:taskarta/mytask/home.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/rounded_button.dart';

import 'Create Task/createtask.dart';
import 'Firebase/auth.dart';
import 'Firebase/Providers/entryprovider.dart';
import 'Login/Login.dart';
import 'Login/signup.dart';
import 'package:taskarta/Firebase/auth.dart';
import 'package:amplify_core/amplify_core.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
Amplify amplifyInstance = Amplify();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginScrn());
}

class LoginScrn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> f = new GlobalKey();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Entryprovider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ProjectProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return UserProvider();
          },
        ),
      ],
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
    _configureAmplify();

  }
  void _configureAmplify() async {
    if (!mounted) return;

    // add all of the plugins we are currently using
    // in our case... just one - Auth
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

      AmplifyAnalyticsPinpoint amplifyAnalyticsPinpoint =
      AmplifyAnalyticsPinpoint();

      AmplifyDataStore datastorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);

      amplifyInstance.addPlugin(
          dataStorePlugins: [datastorePlugin],
          authPlugins: [authPlugin],
          analyticsPlugins: [amplifyAnalyticsPinpoint]);

      await amplifyInstance.configure(amplifyconfig);

      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
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
              'Taskman',
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
                    "Taskman",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
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
                        hintText: 'Email',
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
                      obscureText: obscure,
                      controller: password,
                      cursorColor: Colors.teal[700],
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Colors.teal[700],
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                          ),
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
                        String x = await auth.signIn(
                            username.text.trim(), password.text);
                        if (x == null) {
                          showAboutDialog(context: context, children: [
                            Center(
                              child: LoadingBumpingLine.circle(
                                borderColor: Colors.teal[700],
                              ),
                            )
                          ]);
                        }
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
      List<dynamic> displayname = [
        FirebaseAuth.instance.currentUser.uid.toString()
      ];

      userProvider.changeusername = displayname;
      userProvider.changeuserflag = false;
      return CreatTask();
      // return StreamBuilder<List<Users>>(
      //     stream: userProvider.users,
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) {
      //         return Center(
      //           child: LoadingBumpingLine.circle(
      //             borderColor: Colors.teal[700],
      //           ),
      //         );
      //       }
      //       userProvider.changeCurrentUser = snapshot.data[0];
      //       return Bottom_nav(snapshot.data[0].name);
      //     });
    }
  }
}
