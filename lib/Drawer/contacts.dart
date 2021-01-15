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

class MyContacts extends StatefulWidget {
  @override
  _MyContactsState createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  @override
  Widget build(BuildContext context) {
    print('buildddddddddddddddddddddddddddddddddddd');

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.changeuserflag = true;

    List<String> tag = new List<String>();
    List<Item> tags = new List<Item>();

    DocumentReference gg = FirebaseFirestore.instance
        .collection('user')
        .doc('${userProvider.currentUser.userid}');
    Provider.of<ContactsProvider>(context, listen: false).changeusercontacts =
        userProvider.currentUser.contacts;
    return Builder(
      builder: (v) => Scaffold(
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
                Consumer<ProjectProvider>(
                  builder: (context, cart, child) {
                    return Text(
                      "${tag.length}    Members",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    );
                  },
                ),
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

                    add.remove(gg);
                    userProvider.currentUser.contacts.addAll(add);
                    userProvider.loadAll(userProvider.currentUser);
                    userProvider.saveUser();
                  },
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: Consumer<ContactsProvider>(
                builder: (context, contactsProvider, child) => ListView.builder(
                  // shrinkWrap: true,
                  itemCount: contactsProvider.usercontacts?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${contactsProvider.usercontacts[index].name}",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${contactsProvider.usercontacts[index].email}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
