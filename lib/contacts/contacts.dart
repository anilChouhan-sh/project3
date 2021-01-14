import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';

import 'package:taskarta/Firebase/Providers/userProviders.dart';

import 'package:taskarta/projects/dialog.dart';

import '../Firebase/Providers/projectProvider.dart';

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

class MyContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('buildddddddddddddddddddddddddddddddddddd');
    return Builder(
      builder: (v) => Temp(),
    );
  }
}

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.changeuserflag = true;
    userProvider.changeuserflag = true;
    List<dynamic> gg = [
      FirebaseFirestore.instance
          .collection('user')
          .doc('aZVEouGaN7XH1qKG5S1DWFDmBJE3')
    ];
    userProvider.changeusercontacts = gg;
    List<String> tag = new List<String>();
    List<Item> tags = new List<Item>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mycontacts'),
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: [
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
                          content: Dialogcontains(tag, tags));
                    },
                  );
                },
              ),
              // Consumer<ProjectProvider>(
              //   builder: (context, cart, child) {
              //     return Text(
              //       "${tag.length}    Members",
              //       style: TextStyle(fontWeight: FontWeight.w300),
              //     );
              //   },
              // ),
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                child: Text('ADD'),
                onPressed: () {
                  List<DocumentReference> add = getDoclist(tag);
                  userProvider.currentUser.contacts.forEach((con) {
                    int p = add.indexOf(con);
                    if (p != -1) add.removeAt(p);
                  });

                  userProvider.currentUser.contacts.addAll(add);
                  userProvider.loadAll(userProvider.currentUser);
                  userProvider.saveUser();
                },
              )
            ],
          ),
          Container(
            height: 200,
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) => ListView.builder(
                // shrinkWrap: true,
                itemCount: userProvider.usercontacts?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${userProvider.contacts[index].email}'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
