import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskarta/Firebase/users.dart';
import 'package:taskarta/home.dart';
import 'package:provider/provider.dart';

import 'Firebase/entryprovider.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Entryprovider(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'TasKarta',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.teal[700],
          ),
          body: Log(),
        ),
      ),
    );
  }
}

class Log extends StatelessWidget {
  const Log({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Select A user',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Container(
          child: StreamBuilder<List<Users>>(
              stream: entryProvider.users,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          onTap: () {
                            print(snapshot.data[index].name);
                            /* Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Mytask(user: snapshot.data[index])))*/
                            ;
                          },
                        );
                      });
                }
              }),
        )
      ],
    );
  }
}
