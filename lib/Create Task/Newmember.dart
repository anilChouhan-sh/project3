import 'package:flutter/material.dart';

import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/Providers/projectProvider.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';
import 'package:taskarta/mytask/taskdialog.dart';

import 'package:taskarta/projects/dialog.dart';

class AddMember extends StatefulWidget {
  final entrywhom, pro;
  final List<String> tag;
  AddMember(this.entrywhom, this.pro, this.tag);

  @override
  _AddMemberState createState() => _AddMemberState(entrywhom, pro, tag);
}

class _AddMemberState extends State<AddMember> {
  final GlobalKey<TagsState> _globalkey = new GlobalKey<TagsState>();
  final entrywhom, pro;

  List<String> tag;
  final controller = new TextEditingController();
  _AddMemberState(this.entrywhom, this.pro, this.tag);
  List<Item> tags = new List<Item>();

  // String hello = 'user1';

  // List<DropdownMenuItem> ff(List<Users> user) {
  //   List<DropdownMenuItem> temp = new List();

  //   for (int i = 0; user != null && i < user.length; i++) {
  //     var value = user.elementAt(i).userid;
  //     var name = user.elementAt(i).name;

  //     print(value);
  //     temp.add(DropdownMenuItem(child: Text('$name'), value: name));
  //   }
  //   return temp;
  // }

  // String selectedNumber = '';
  bool closed = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    closed = false;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {});
            showDialog(
              context: context,
              builder: (context) {
                Provider.of<ContactsProvider>(context, listen: false)
                    .changeusercontacts = userProvider.currentUser.contacts;
                return AlertDialog(
                    title: Text("select"),
                    content: TaskDialog(widget.tag, tags));
              },
            );
          },
        ),
        Consumer<ProjectProvider>(
          builder: (context, cart, child) {
            return Text(
              "${widget.tag.length}    Members",
              style: TextStyle(fontWeight: FontWeight.w300),
            );
          },
        )
      ],
    );
    // return Container(
    //   width: 20,
    //   child: StreamBuilder<List<Users>>(
    //     stream: pro.users,
    //     builder: (contex, snapshot) {
    //       List<DropdownMenuItem> fff = ff(snapshot.data);
    //       return Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           SearchableDropdown.single(
    //             items: fff,
    //             value: selectedNumber,
    //             hint: "Assign Users",
    //             searchHint: "Select a user",
    //             validator: (v) {
    //               var x = v.toString();
    //               print("valueeeeeeeeeeeeeeee-------$x");
    //             },
    //             onChanged: (value) {
    //               setState(() {
    //                 selectedNumber = value;
    //                 if (value != null) {
    //                   snapshot.data.forEach((element) {
    //                     if (element.name == value &&
    //                         !tag.contains(element.userid) &&
    //                         !closed) {
    //                       tag.add(element.userid);
    //                       tags.add(Item(title: value.toString()));
    //                     }
    //                   });
    //                 }
    //               });
    //             },
    //             closeButton: RaisedButton(
    //               child: Text("Close"),
    //               onPressed: () => {
    //                 setState(() {
    //                   selectedNumber = "null";
    //                   Navigator.pop(context);
    //                   closed = true;
    //                 })
    //               },
    //             ),
    //             assertUniqueValue: true,
    //             displayClearIcon: false,
    //             disabledHint: true,
    //             dialogBox: true,
    //             isExpanded: false,
    //           ),
    //           Container(
    //             width: 250,
    //             height: 60,
    //             child: ListView(
    //                 scrollDirection: Axis.horizontal,
    //                 shrinkWrap: true,
    //                 children: [
    //                   Tags(
    //                     horizontalScroll: true,
    //                     direction: Axis.horizontal,
    //                     key: _globalkey,
    //                     itemCount: tags.length,
    //                     columns: 1,
    //                     itemBuilder: (index) {
    //                       final Item current = tags[index];
    //                       return ItemTags(
    //                         pressEnabled: false,
    //                         index: index,
    //                         activeColor: Colors.teal[700],
    //                         color: Colors.teal[700],
    //                         title: current.title,
    //                         customData: current.customData,
    //                         textStyle: TextStyle(fontSize: 18),
    //                         combine: ItemTagsCombine.imageOrIconOrText,
    //                         removeButton: ItemTagsRemoveButton(onRemoved: () {
    //                           setState(() {
    //                             tag.removeAt(index);
    //                             tags.removeAt(index);
    //                           });
    //                           return true;
    //                         }),
    //                       );
    //                     },
    //                   ),
    //                 ]),
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}
