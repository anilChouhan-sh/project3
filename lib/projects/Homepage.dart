import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/projects/dialog.dart';
import './project.dart';
import 'create_project.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Homepage extends StatelessWidget {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Builder(
            builder: (context) => Container(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Create_project(),
                  //     ));
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: Container(
                              height: 400,
                              width: 300,
                              //color: Colors.transparent,
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 10,
                                    shadowColor: Colors.teal[700],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 50),
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      key: _formKey,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              )),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          hintText: 'Project Name',
                                          fillColor: Colors.teal[50]),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text("select"),
                                              content: Dialogcontains());
                                        },
                                      );
                                    },
                                  ),
                                  RaisedButton(
                                    elevation: 10,
                                    onPressed: () {},
                                    color: Colors.teal[700],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                          ));
                },
                backgroundColor: Colors.blueGrey[100],
                splashColor: Colors.indigoAccent[400],
                child: Icon(
                  CupertinoIcons.plus,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: false,
                  backgroundColor: Colors.blue,
                  flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(bottom: 175),
                      centerTitle: true,
                      title: Text("APP NAME",
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                      background: Image.asset(
                        "image/task.jpg",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 15),
                    child: RichText(
                      text: TextSpan(
                        text: 'Hello, ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Anil!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 0),
                    child: ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          RaisedButton(
                            elevation: 2,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            onPressed: () {},
                            child: Text("ALL"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Colors.white54,
                            splashColor: Colors.indigo[400],
                          ),
                          RaisedButton(
                            elevation: 2,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            onPressed: () {},
                            child: Text("Favourites"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Colors.white54,
                            splashColor: Colors.indigo[400],
                          ),
                          RaisedButton(
                            elevation: 2,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            onPressed: () {},
                            child: Text("Recent"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Colors.white54,
                            splashColor: Colors.indigo[400],
                          )
                        ]),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                    itemBuilder: (context, index) {
                      return new Project();
                    },
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
