import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/Providers/projectProvider.dart';
import 'package:taskarta/projects/dialog.dart';

class Create_Project extends StatefulWidget {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController projectname;
  List<String> tag;
  List<Item> tags;

  Create_Project({this.projectname, this.tag, this.tags});

  @override
  _Create_ProjectState createState() => _Create_ProjectState();
}

class _Create_ProjectState extends State<Create_Project> {
  List<DocumentReference> getDoclist(List<String> tag) {
    print('yourrrrr valusssss${tag.toString()}');
    List<DocumentReference> refer = [];
    for (int i = 0; i < tag.length; i++) {
      DocumentReference ref =
          FirebaseFirestore.instance.collection('user').doc(tag[i]);
      refer.add(ref);
    }
    return refer;
  }

  @override
  Widget build(BuildContext context) {
    final projectProvider =
        Provider.of<ProjectProvider>(context, listen: false);
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String due = DateFormat("yyyy-MM-dd ").format(selectedDate) +
        selectedTime.hour.toString() +
        ":" +
        selectedTime.minute.toString() +
        ":00";
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          height: 250,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                // key: _formKey,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50),
                  child: TextFormField(
                    controller: widget.projectname,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        hintText: 'Project Name',
                        fillColor: Colors.teal[50]),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      //setState(() {});
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text("select"),
                              content: Dialogcontains(widget.tag, widget.tags));
                        },
                      );
                    },
                  ),
                  Consumer<ProjectProvider>(
                    builder: (context, cart, child) {
                      return Text(
                        "${widget.tag.length}    Members",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      );
                    },
                  )
                ],
              ),
              RaisedButton(
                elevation: 10,
                onPressed: () {
                  //createprojects and save to firebase

                  projectProvider.changeProject_name = widget.projectname.text;
                  projectProvider.changeStart_date = due;

                  projectProvider.changeCreated_by = FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser.uid);
                  projectProvider.changeMembers = getDoclist(widget.tag);
                  projectProvider.changetasks = [];
                  print('yourrrrr valusssss${widget.tag.toString()}');
                  print(projectProvider.members);
                  projectProvider.saveProject();

                  Navigator.pop(context);
                },
                color: Colors.teal[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        // showFloatingModalBottomSheet(
        //             context: context,
        //             builder: (context) => Container(height: 500,width: 300,)
        //           ),
      ),
    );
  }
}
