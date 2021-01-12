import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/projectProvider.dart';
import 'package:taskarta/Firebase/projects.dart';

class Show_Project extends StatelessWidget {
  Projects project;
  Show_Project(this.project);
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    final entryProvider = Provider.of<Entryprovider>(context);
    return Container(
      height: 130,
      child: Card(
          color: Colors.teal[700],
          margin: EdgeInsets.symmetric(vertical: 5),
          elevation: 20,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  //  color: Colors.white,

                  padding:
                      EdgeInsets.only(top: 32, left: 20, right: 10, bottom: 25),
                  child: CircularPercentIndicator(
                    radius: 45.0,
                    lineWidth: 5.0,
                    percent: 0.4,
                    progressColor: Colors.indigoAccent[400],
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 25),
                    Text("Tasks - " + project.tasks.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(project.project_name,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        )),
                    Text("Date" + project.start_date,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  Card(
                    color: Colors.teal[700],
                    elevation: 5,
                    margin: const EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.circle_filled,
                      size: 10,
                      color: project.created_by == entryProvider.currentUser.ref
                          ? Colors.white
                          : Colors.teal[700],
                    ),
                  ),
                  Container(
                    //  padding: EdgeInsets.only(top: 30, left: 45),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('Options'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text('Delete'),
                                    onTap: () {
                                      projectProvider.deleteProject(
                                          project.projectID, 'projects');
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ));
                      },
                      icon: Icon(
                        CupertinoIcons.ellipsis_vertical,
                      ),
                      iconSize: 35,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
