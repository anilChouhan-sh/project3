import 'dart:math';

import 'package:amplify_flutter/amplify.dart';
import 'package:taskarta/models/Tasks.dart';

class datastore{

  Future<Stream<List<Tasks>>> getEntries() async {
    List<Tasks> task = await Amplify.DataStore.query(Tasks.classType);
    print(task[0].title.toString());
  }

}