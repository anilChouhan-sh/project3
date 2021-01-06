import 'package:flutter/material.dart';
import 'package:taskarta/mytask/task.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Create Task/createtask.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/entry.dart';

class By_me extends StatelessWidget {
  final userid, name;
  By_me({this.userid, this.name});

  Stream xyz(entryProvider) {
    entryProvider.changevalue = userid;
    entryProvider.changeflag = false;
    entryProvider.changecondition = 'userid';
    entryProvider.changecollection = 'task';
    return entryProvider.entries;
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);
    Stream y = xyz(entryProvider);
    ;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreatTask(userid: userid, name: name)));
          }),
      body: StreamBuilder<List<Entry>>(
          stream: y,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading');
            } else {
              snapshot.data.sort(
                  (a, b) => (a.done.toString()).compareTo(b.done.toString()));
              return ListView.builder(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 0, left: 20, right: 20),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                        child: Task(
                          data: snapshot.data[index],
                          flag: true,
                        ),
                        onTap: () {
                          print(name);
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}