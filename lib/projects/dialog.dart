import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';

import 'package:taskarta/Firebase/Providers/entryprovider.dart';
import 'package:taskarta/Firebase/Providers/projectProvider.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';

import 'package:taskarta/Firebase/users.dart';

class Dialogcontains extends StatefulWidget {
  final List<String> tag;
  List<Item> tags;
  Dialogcontains(this.tag, this.tags);
  @override
  _DialogcontainsState createState() => _DialogcontainsState();
}

class _DialogcontainsState extends State<Dialogcontains> {
  GlobalKey<TagsState> _globalkey = new GlobalKey<TagsState>();
  TextEditingController _searchcontroller = new TextEditingController();
  List<Users> allusers = new List<Users>();
  List<Users> _selectedusers = new List<Users>();

  String _search = "";

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final proProvider = Provider.of<ProjectProvider>(context, listen: false);

    ProjectProvider p = new ProjectProvider();
    userProvider.changeuserflag = true;
    _selectedusers.clear();
    bool closed = false;

    if (!widget.tag.contains(userProvider.currentUser.userid)) {
      widget.tag.add(userProvider.currentUser.userid);
      widget.tags.add(Item(title: userProvider.currentUser.name.toString()));
    }

    closed = false;
    userProvider.changeuserflag = true;

    return Container(
      height: 450,
      width: 600,
      child: SingleChildScrollView(
          child: Consumer<ProjectProvider>(builder: (context, provider, child) {
        allusers.clear();
        provider.promem.forEach((data) {
          if (data.name.toLowerCase().contains(_search.toLowerCase())) {
            print("hfakjhskjfhlkjshadkjfhljkh ${_searchcontroller.text}");
            allusers.add(data);
          }
        });
        return Column(
          children: [
            Container(
              child: TextField(
                controller: _searchcontroller,
                onChanged: (value) {
                  setState(() {
                    _search = value;
                    allusers.clear();
                  });
                  print(_selectedusers);
                },
              ),
            ),
            Container(
              height: 250,
              width: 250,
              child: ListView.builder(
                itemCount: allusers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(allusers[index].name),
                    onTap: () {
                      _selectedusers.add(allusers[index]);
                      setState(() {
                        if (index != null) {
                          provider.promem.forEach((element) {
                            if (element.name == allusers[index].name &&
                                !widget.tag.contains(element.userid) &&
                                !closed) {
                              widget.tag.add(element.userid);
                              widget.tags.add(
                                  Item(title: allusers[index].name.toString()));
                            }
                          });
                        }
                      });
                      print("${widget.tag.toString()}");
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
              padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
              decoration: BoxDecoration(
                  color: Colors.teal[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal[100])),
              child: SingleChildScrollView(
                child: Tags(
                  key: _globalkey,
                  itemCount: widget.tags.length,
                  columns: 5,
                  itemBuilder: (index) {
                    final Item current = widget.tags[index];
                    return ItemTags(
                      pressEnabled: false,
                      index: index,
                      activeColor: Colors.teal[700],
                      color: Colors.teal[700],
                      title: current.title,
                      customData: current.customData,
                      textStyle: TextStyle(fontSize: 14),
                      combine: ItemTagsCombine.imageOrIconOrText,
                      removeButton: ItemTagsRemoveButton(onRemoved: () {
                        setState(() {
                          widget.tag.removeAt(index);
                          widget.tags.removeAt(index);
                        });
                        return true;
                      }),
                    );
                  },
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                _searchcontroller.clear();
                proProvider.changeNum = widget.tag.length.toString();
                allusers.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      })),
    );

    /*return Container(
      height: 450,
      width: 600,
      child: SingleChildScrollView(
        child: StreamBuilder<List<Users>>(
            stream: userProvider.users,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }

              allusers.clear();
              snapshot.data.forEach((data) {
                if (data.name.toLowerCase().contains(_search.toLowerCase())) {
                  print("hfakjhskjfhlkjshadkjfhljkh ${_searchcontroller.text}");
                  allusers.add(data);
                }
              });
              return Column(
                children: [
                  Container(
                    child: TextField(
                      controller: _searchcontroller,
                      onChanged: (value) {
                        setState(() {
                          _search = value;
                          allusers.clear();
                        });
                        print(_selectedusers);
                      },
                    ),
                  ),
                  Container(
                    height: 250,
                    width: 250,
                    child: ListView.builder(
                      itemCount: allusers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(allusers[index].name),
                          onTap: () {
                            _selectedusers.add(allusers[index]);
                            setState(() {
                              if (index != null) {
                                snapshot.data.forEach((element) {
                                  if (element.name == allusers[index].name &&
                                      !widget.tag.contains(element.userid) &&
                                      !closed) {
                                    widget.tag.add(element.userid);
                                    widget.tags.add(Item(
                                        title:
                                            allusers[index].name.toString()));
                                  }
                                });
                              }
                            });
                            print("${widget.tag.toString()}");
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                    padding:
                        EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.teal[100])),
                    child: SingleChildScrollView(
                      child: Tags(
                        key: _globalkey,
                        itemCount: widget.tags.length,
                        columns: 5,
                        itemBuilder: (index) {
                          final Item current = widget.tags[index];
                          return ItemTags(
                            pressEnabled: false,
                            index: index,
                            activeColor: Colors.teal[700],
                            color: Colors.teal[700],
                            title: current.title,
                            customData: current.customData,
                            textStyle: TextStyle(fontSize: 14),
                            combine: ItemTagsCombine.imageOrIconOrText,
                            removeButton: ItemTagsRemoveButton(onRemoved: () {
                              setState(() {
                                widget.tag.removeAt(index);
                                widget.tags.removeAt(index);
                              });
                              return true;
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _searchcontroller.clear();
                      proProvider.changeNum = widget.tag.length.toString();
                      allusers.clear();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }),
      ),
    );*/
  }
}
