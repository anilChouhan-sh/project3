import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/entryprovider.dart';
import 'package:taskarta/Firebase/users.dart';
import './project.dart';
import 'create_project.dart';

class Dialogcontains extends StatefulWidget {
  @override
  _DialogcontainsState createState() => _DialogcontainsState();
}

class _DialogcontainsState extends State<Dialogcontains> {
  GlobalKey<TagsState> _globalkey = new GlobalKey<TagsState>();
  TextEditingController _searchcontroller = new TextEditingController();
  List<Users> allusers = new List<Users>();
  List<Users> _selectedusers = new List<Users>();
  List<Item> tags = new List<Item>();
  String _search = "";

  void _addTotags(Users user) {
    tags.add(Item(title: '${user.name}'));
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context);
    entryProvider.changeuserflag = true;
    _selectedusers.clear();
    return Container(
      height: 450,
      width: 600,
      child: SingleChildScrollView(
        child: StreamBuilder<List<Users>>(
            stream: entryProvider.users,
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
                              _addTotags(allusers[index]);
                            });
                            print("${_selectedusers.toString()}");
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
                        itemCount: tags.length,
                        columns: 5,
                        itemBuilder: (index) {
                          final Item current = tags[index];
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
                                // tag.removeAt(index);
                                tags.removeAt(index);
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

                      allusers.clear();
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}
