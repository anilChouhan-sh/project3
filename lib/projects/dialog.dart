import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/users.dart';
import './project.dart';
import 'create_project.dart';

class Dialogcontains extends StatefulWidget {
  @override
  _DialogcontainsState createState() => _DialogcontainsState();
}

class _DialogcontainsState extends State<Dialogcontains> {
  TextEditingController _searchcontroller = new TextEditingController();
  List<Users> allusers = new List<Users>();
  String _search = "";
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);

    return Container(
      height: 400,
      width: 400,
      child: SingleChildScrollView(
        child: StreamBuilder<List<Users>>(
            stream: entryProvider.users,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }
              allusers.clear();
              snapshot.data.forEach((data) {
                if (data.name.contains(_search)) {
                  print("hfakjhskjfhlkjshadkjfhljkh ${_searchcontroller.text}");
                  allusers.add(data);
                }
              });
              return Column(
                children: [
                  Container(
                    child: TextField(
                      controller: _searchcontroller,
                      onChanged: (value) {
                        setState(() {
                          _search = value;
                          allusers.clear();
                        });
                        print(_search);
                      },
                    ),
                  ),
                  Container(
                    height: 250,
                    width: 250,
                    child: ListView.builder(
                      itemCount: allusers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(allusers[index].name),
                        );
                      },
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _searchcontroller.clear();

                      allusers.clear();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
