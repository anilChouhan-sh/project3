import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';
import 'package:uuid/uuid.dart';
import './Picturecapture.dart';
import './Newmember.dart';
import 'CelendaR.dart';
import 'package:taskarta/Firebase/entry.dart';
import 'package:taskarta/Firebase/Providers/entryprovider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final Entry entry;
  final text;
  final bool validate;
  Body({this.entry, this.text, this.validate});

  @override
  _BodyState createState() => _BodyState(text, validate);
}

class _BodyState extends State<Body> {
  final text;
  final bool validate;
  _BodyState(this.text, this.validate);
  final entryController = TextEditingController();
  final entrywhom = TextEditingController();
  final entrydes = TextEditingController();
  final List<String> tag = new List();
  final HashMap ids = new HashMap<String, String>();
  var uuid = Uuid();

  // @override
  // void initState() {
  //   final entryProvider = Provider.of<Entryprovider>(context, listen: false);
  //   if (widget.entry != null) {
  //     //Edit
  //     entryController.text = widget.entry.title;
  //     entrywhom.text = widget.entry.whom;
  //     entrydes.text = widget.entry.description;
  //     entryProvider.loadAll(widget.entry);
  //   } else {
  //     //Add
  //     entryProvider.loadAll(null);
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ProjectName(
              size: size,
              entryController: entryController,
              tag: tag,
              text: text),
          MemberAndDate(
              entrywhom: entrywhom, pro: entryProvider, tag: tag, ids: ids),
          SizedBox(
            height: 10,
          ),
          Container(
            child: DueDate(),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 80,
            padding: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: entrydes,
                    onChanged: (String value) => {
                      entryProvider.changedescription = value,
                      //   entryProvider.changeid
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15, right: 15),
                      hintText: 'More about task',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.8)),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 150,
            // color: Colors.amber,
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 90,
            padding: EdgeInsets.only(right: 8),
            child: Row(
              children: <Widget>[
                Container(
                  child: Picturecapture(),
                ),
                SizedBox(
                  width: 1,
                ),
                Container(
                  child: Icon(
                    Icons.attach_file,
                    size: 30,
                    color: Colors.teal[700],
                  ),
                ),
                SizedBox(
                  width: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemberAndDate extends StatelessWidget {
  final entrywhom, pro;
  final List<String> tag;
  final Map ids;
  MemberAndDate({Key key, this.entrywhom, this.pro, this.tag, this.ids})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, right: 10, left: 10),
      child: ChangeNotifierProvider(
          create: (context) => ContactsProvider(),
          child: AddMember(entrywhom, pro, tag)),
    );
  }
}

class ProjectName extends StatefulWidget {
  final Size size;
  final entryController;
  final List<String> tag;
  final bool validate;
  final text;
  ProjectName(
      {Key key,
      @required this.size,
      @required this.entryController,
      this.tag,
      this.text,
      this.validate})
      : super(key: key);

  @override
  _ProjectNameState createState() => _ProjectNameState(text, validate);
}

class _ProjectNameState extends State<ProjectName> {
  final text;
  bool validate;
  _ProjectNameState(this.text, this.validate);

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context, listen: false);
    String task;
    return Container(
      height: widget.size.height * 0.3 - 37,
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 15.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
        color: Colors.teal[700],
      ),
      padding: EdgeInsets.only(top: 2, left: 50),
      child: Container(
        padding: EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                print(widget.tag);
                if (widget.tag.isEmpty) {
                  entryProvider.changewhom = [
                    FirebaseAuth.instance.currentUser.uid
                  ];
                } else {
                  entryProvider.changewhom = widget.tag;
                }
                entryProvider.changetitle = value;
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
              controller: widget.entryController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.assignment,
                    size: 55,
                    color: Colors.white,
                  ),
                  hintText: 'Task Name '),
            ),
          ],
        ),
      ),
    );
  }
}
