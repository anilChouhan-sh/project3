/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Tasks type in your schema. */
@immutable
class Tasks extends Model {
  static const classType = const TasksType();
  final String id;
  final String date;
  final String desc;
  final bool done;
  final String title;
  final String UserID;
  final List<String> whom;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Tasks._internal(
      {@required this.id,
      @required this.date,
      @required this.desc,
      @required this.done,
      @required this.title,
      @required this.UserID,
      @required this.whom});

  factory Tasks(
      {@required String id,
      @required String date,
      @required String desc,
      @required bool done,
      @required String title,
      @required String UserID,
      @required List<String> whom}) {
    return Tasks._internal(
        id: id == null ? UUID.getUUID() : id,
        date: date,
        desc: desc,
        done: done,
        title: title,
        UserID: UserID,
        whom: whom != null ? List.unmodifiable(whom) : whom);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Tasks &&
        id == other.id &&
        date == other.date &&
        desc == other.desc &&
        done == other.done &&
        title == other.title &&
        UserID == other.UserID &&
        DeepCollectionEquality().equals(whom, other.whom);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Tasks {");
    buffer.write("id=" + id + ", ");
    buffer.write("date=" + date + ", ");
    buffer.write("desc=" + desc + ", ");
    buffer.write("done=" + (done != null ? done.toString() : "null") + ", ");
    buffer.write("title=" + title + ", ");
    buffer.write("UserID=" + UserID + ", ");
    buffer.write("whom=" + (whom != null ? whom.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Tasks copyWith(
      {String id,
      String date,
      String desc,
      bool done,
      String title,
      String UserID,
      List<String> whom}) {
    return Tasks(
        id: id ?? this.id,
        date: date ?? this.date,
        desc: desc ?? this.desc,
        done: done ?? this.done,
        title: title ?? this.title,
        UserID: UserID ?? this.UserID,
        whom: whom ?? this.whom);
  }

  Tasks.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        desc = json['desc'],
        done = json['done'],
        title = json['title'],
        UserID = json['UserID'],
        whom = json['whom']?.cast<String>();

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'desc': desc,
        'done': done,
        'title': title,
        'UserID': UserID,
        'whom': whom
      };

  static final QueryField ID = QueryField(fieldName: "tasks.id");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField DESC = QueryField(fieldName: "desc");
  static final QueryField DONE = QueryField(fieldName: "done");
  static final QueryField TITLE = QueryField(fieldName: "title");
  static final QueryField USERID = QueryField(fieldName: "UserID");
  static final QueryField WHOM = QueryField(fieldName: "whom");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Tasks";
    modelSchemaDefinition.pluralName = "Tasks";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tasks.DATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tasks.DESC,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tasks.DONE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tasks.TITLE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tasks.USERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Tasks.WHOM,
        isRequired: true,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));
  });
}

class TasksType extends ModelType<Tasks> {
  const TasksType();

  @override
  Tasks fromJson(Map<String, dynamic> jsonData) {
    return Tasks.fromJson(jsonData);
  }
}
