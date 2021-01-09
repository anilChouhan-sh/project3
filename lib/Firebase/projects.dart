import 'package:cloud_firestore/cloud_firestore.dart';

class Projects {
  DocumentReference created_by;
  String project_name;
  String start_date;
  String projectID;
  dynamic tasks;
  dynamic members;
  Projects(
      {this.created_by,
      this.members,
      this.project_name,
      this.start_date,
      this.tasks,
      this.projectID});

  factory Projects.fromJson(Map<String, dynamic> json) {
    return Projects(
        created_by: json['created_by'],
        projectID: json['projectID'],
        members: json['members'],
        project_name: json['project_name'],
        start_date: json['start_date'],
        tasks: json["tasks"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'project_name': project_name,
      'created_by': created_by,
      'start_date': start_date,
      'members': members,
      'tasks': tasks,
      'projectID': projectID
    };
  }
}
