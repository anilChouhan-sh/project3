import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';

import 'package:taskarta/Firebase/projectProvider.dart';
import 'package:taskarta/Firebase/projects.dart';
import 'package:taskarta/projects/create_project.dart';
import 'package:taskarta/projects/projectDetails.dart';
import 'package:taskarta/projects/safeus.dart';
import 'package:flutter_tags/flutter_tags.dart';
import './project.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Homepage extends StatelessWidget {
  TextEditingController projectname = new TextEditingController();
  List<String> tag = [];
  List<Item> tags = new List<Item>();
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final entryProvider = Provider.of<Entryprovider>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       fullscreenDialog: false,
              //       builder: (context) => Safeus(),
              //     ));

              projectname.clear();
              tag.clear();
              tags.clear();
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0))),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Create_Project(
                        projectname: projectname,
                        tag: tag,
                        tags: tags,
                      ));
            },
            backgroundColor: Colors.orangeAccent,
            splashColor: Colors.indigoAccent[400],
            child: Icon(
              Icons.playlist_add,
              color: Colors.white,
              size: 30,
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
                  backgroundColor: Colors.teal[100],
                  flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(bottom: 175),
                      centerTitle: true,
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
                  Consumer<Entryprovider>(
                    builder: (context, entryProvider, _) {
                      return Container(
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
                                  text: entryProvider.currentUser.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                      );
                    },
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
                      child: StreamBuilder<List<Projects>>(
                    stream: projectProvider.projects,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                projectProvider.changecurrentProject =
                                    snapshot.data[index];

                                projectProvider.changecurr_tasks =
                                    snapshot.data[index].tasks;
                                print(snapshot.data[index].members);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProjectDetails()));
                              },
                              child: new Show_Project(snapshot.data[index]));
                        },
                      );
                    },
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
