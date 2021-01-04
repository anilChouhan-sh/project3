import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'create.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/entry.dart';
import 'package:provider/provider.dart';

class CreatTask extends StatefulWidget {
  final String userid;
  final String name;
  bool validate = false;
  final text = TextEditingController();
  CreatTask({this.userid, this.name});

  @override
  _CreatTaskState createState() => _CreatTaskState(text, validate, name);
}

class _CreatTaskState extends State<CreatTask> {
  bool check;
  final text;
  bool validate;
  String name;
  _CreatTaskState(this.text, this.validate, this.name);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Scaffold(
        floatingActionButton: Container(
          height: 80,
          width: 80,
          padding: EdgeInsets.only(bottom: 15, right: 15),
          child: FloatingActionButton(
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            elevation: 5,
            onPressed: () {
              setState(() {
                if (!_formKey.currentState.validate()) {
                  validate = true;
                  print('errororororo');
                } else {
                  validate = false;

                  entryProvider.changeuserid = widget.userid;
                  entryProvider.changedone = false;
                  entryProvider.saveEntry();
                  Navigator.pop(context);
                }
              });
            },
            backgroundColor: Colors.teal[700],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Text(
                "            Create New Task",
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.teal[700],
        ),
        body: Body(text: text, validate: validate),
      ),
    );
  }
}
