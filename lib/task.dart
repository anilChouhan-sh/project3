import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:provider/provider.dart';
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
    final provider = Provider.of<Entryprovider>(context);
    List<dynamic> nameCondition = new List<dynamic>();
    nameCondition.add(widget.data.userid);
    String getNames(List<Users> user) {
      String x;
      if (widget.flag) {
        List p = user;
        x = 'To :';
        p.forEach((element) {
          x = x + ' ' + element.name;
        });
      } else {
        x = 'By : ';
        x = x + user[0].name;
      }
      return x;
    }

    if (widget.flag) {
      provider.changeusername = widget.data.whom;
    } else {
      provider.changeusername = nameCondition;
    }
    print(widget.data.done.toString());

    return StreamBuilder<List<Users>>(
      stream: provider.users,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Card(
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
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 9.0, bottom: 9, right: 9.0),
                          child: Text(
                            getNames(snapshot.data),
                            textScaleFactor: 1.3,
                            style: TextStyle(fontWeight: FontWeight.w300),
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
                                      provider.loadAll(widget.data);
                                      provider.changeid = widget.data.id;
                                      provider.changedone = true;
                                      provider.saveEntry();
                                    } else {
                                      provider.loadAll(widget.data);
                                      provider.changeid = widget.data.id;
                                      provider.changedone = false;
                                      provider.saveEntry();
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
            ),
          );
        } else {
          return Text('Loading');
        }
      },
    );
  }
}
