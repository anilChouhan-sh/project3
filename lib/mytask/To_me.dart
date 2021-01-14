import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:taskarta/mytask/task.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Create Task/createtask.dart';
import 'package:taskarta/Firebase/Providers/entryprovider.dart';
import 'package:taskarta/Firebase/entry.dart';

class To_me extends StatelessWidget {
  final String userid, name, condition, collection;
  bool flag;
  To_me({this.userid, this.name, this.collection, this.condition});

  // Stream xyz(entryProvider) {
  //   condition == 'whom' ? flag = false : flag = true;
  //   entryProvider.changevalue = userid;
  //   entryProvider.changeflag = false;
  //   entryProvider.changecondition = condition;
  //   entryProvider.changecollection = collection;
  //   condition == 'whom' ? flag = false : flag = true;
  //   return entryProvider.entries;
  // }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context, listen: false);
    Stream xyz(entryProvider) {
      condition == 'whom' ? flag = false : flag = true;
      entryProvider.changevalue = userid;
      entryProvider.changeflag = flag;
      entryProvider.changecondition = condition;
      entryProvider.changecollection = collection;

      return entryProvider.entries;
    }

    Stream y = xyz(entryProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: 'actionbutton',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreatTask(userid: userid, name: name)));
          }),
      body: StreamBuilder<List<Entry>>(
          stream: y,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LoadingBumpingLine.circle(
                  borderColor: Colors.teal[700],
                ),
              );
            } else {
              snapshot.data.sort(
                  (a, b) => (a.done.toString()).compareTo(b.done.toString()));
              return ListView.builder(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: InkWell(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      "Are you sure you want to delete task : -${snapshot.data[index].title}?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        entryProvider.removeEntry(
                                            snapshot.data[index].id, "task");
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        splashColor: Colors.teal[700],
                        highlightColor: Colors.teal[700],
                        child: Task(data: snapshot.data[index], flag: flag),
                        onTap: () {
                          print('TAPEDDDDDDDDDDHGSAKHJDKHJA');
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
