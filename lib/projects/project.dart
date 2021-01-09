import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskarta/Firebase/projects.dart';

class Show_Project extends StatelessWidget {
  Projects project;
  Show_Project(this.project);
  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.only(top: 30, left: 45),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.ellipsis_vertical),
                  iconSize: 35,
                ),
              )
            ],
          )),
    );
  }
}
