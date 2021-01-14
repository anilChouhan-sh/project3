import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:taskarta/Firebase/Providers/entryprovider.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';
import 'package:taskarta/Firebase/users.dart';

class Task extends StatefulWidget {
  final data;
  final flag;
  Task({this.data, this.flag});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    final entryEntry = Provider.of<Entryprovider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<dynamic> nameCondition = new List<dynamic>();
    nameCondition.add(widget.data.userid);
    int len;
    String getNames(List<Users> user) {
      String x;
      if (widget.flag) {
        List p = user;
        x = 'To :';
        p.forEach((element) {
          x = x + ' ' + element.name + ',';
        });
        len = x.length - 1;
      } else {
        x = 'By : ';
        x = x + user[0].name;
        len = x.length;
      }

      return x;
    }

    if (widget.flag) {
      userProvider.changeusername = widget.data.whom;
      userProvider.changeuserflag = false;
    } else {
      userProvider.changeusername = nameCondition;
      userProvider.changeuserflag = false;
    }
    print(widget.data.done.toString());

    return StreamBuilder<List<Users>>(
      stream: userProvider.users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            color: widget.data.done == true ? Colors.teal[300] : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0),
                        child: Text(
                          widget.data.title,
                          textScaleFactor: 2,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, bottom: 9, right: 9.0),
                        child: Text(
                          widget.data.description,
                          textScaleFactor: 1.3,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, bottom: 9, right: 9.0),
                        child: Text(
                          "Due:  " +
                              DateFormat("EEE   dd/MM/yyyy  H:m")
                                  .format(DateTime.parse(widget.data.date)),
                          textScaleFactor: 1.1,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 9.0, bottom: 9, right: 9.0),
                        child: Text(
                          getNames(snapshot.data).substring(0, len),
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.flag == false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Checkbox(
                              value: widget.data.done,
                              tristate: true,
                              activeColor: Colors.teal[700],
                              /*  icon: Icon(
                        widget.data.done == true ? Icons.undo : Icons.done),*/
                              onChanged: (bool value) {
                                setState(() {
                                  if (widget.data.done == false) {
                                    entryEntry.loadAll(widget.data);
                                    entryEntry.changeid = widget.data.id;
                                    entryEntry.changedone = true;
                                    entryEntry.saveEntry();
                                  } else {
                                    entryEntry.loadAll(widget.data);
                                    entryEntry.changeid = widget.data.id;
                                    entryEntry.changedone = false;
                                    entryEntry.saveEntry();
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      )
                    : Column()
              ],
            ),
          );
        } else {
          return Center(
            child: LoadingBumpingLine.circle(
              borderColor: Colors.teal[700],
            ),
          );
        }
      },
    );
  }
}
