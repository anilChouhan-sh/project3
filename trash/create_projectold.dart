// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tags/flutter_tags.dart';
// import 'package:provider/provider.dart';
// import 'package:taskarta/Firebase/entryprovider.dart';
// import 'package:taskarta/Firebase/users.dart';
// import 'package:taskarta/projects/dialog.dart';

// class Create_project extends StatefulWidget {
//   @override
//   _Create_projectState createState() => _Create_projectState();
// }

// class _Create_projectState extends State<Create_project> {
//   GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   GlobalKey<TagsState> _globalkey = new GlobalKey<TagsState>();
//   List tags = [
//     Item(title: 'Lakshay Maheswari'),
//     Item(title: 'Anil Chouhan'),
//     Item(title: 'Lakshay Maheswari'),
//     Item(title: 'Raju bhai'),
//     Item(title: 'Lakshay Maheswari'),
//     Item(title: 'Raju bhai'),
//     Item(title: 'Lakshay Maheswari'),
//     Item(title: 'Raju bhai'),
//     Item(title: 'Lakshay Maheswari'),
//     Item(title: 'Raju bhai'),
//     Item(title: 'Lakshay Maheswari'),
//     Item(title: 'Raju bhai'),
//   ];
//   List tag = new List();

//   TextEditingController _searchcontroller = new TextEditingController();
//   List<Users> allusers = new List<Users>();
//   String _search = "";
//   @override
//   Widget build(BuildContext context) {
//     final entryProvider = Provider.of<Entryprovider>(context);
//     List<dynamic> displayname = [
//       FirebaseAuth.instance.currentUser.uid.toString()
//     ];
//     entryProvider.changeusername = displayname;
//     entryProvider.changeuserflag = true;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text('Create Project',
//             style: TextStyle(color: Colors.teal[700], fontSize: 24)),
//         iconTheme: IconThemeData(color: Colors.teal[700]),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Form(
//           child: Column(
//             children: [
//               Card(
//                 elevation: 10,
//                 shadowColor: Colors.teal[700],
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50),
//                 child: TextFormField(
//                   textCapitalization: TextCapitalization.sentences,
//                   key: _formKey,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           )),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       hintText: 'Project Name',
//                       fillColor: Colors.teal[50]),
//                 ),
//               ),
//               Card(
//                   elevation: 10,
//                   shadowColor: Colors.teal[700],
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50),
//                   child:
//                       /* TextFormField(
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           )),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       hintText: 'Add Members',
//                       fillColor: Colors.teal[50]),
//                 ),*/
//                       Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                     IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                                 title: Text("select"),
//                                 content: Dialogcontains());
//                           },
//                         );
//                       },
//                     )
//                   ])),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
//                 padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
//                 decoration: BoxDecoration(
//                     color: Colors.teal[100],
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.teal[100])),
//                 height: 200,
//                 width: 350,
//                 child: SingleChildScrollView(
//                   child: Tags(
//                     key: _globalkey,
//                     itemCount: tags.length,
//                     columns: 5,
//                     itemBuilder: (index) {
//                       final Item current = tags[index];
//                       return ItemTags(
//                         pressEnabled: false,
//                         index: index,
//                         activeColor: Colors.teal[700],
//                         color: Colors.teal[700],
//                         title: current.title,
//                         customData: current.customData,
//                         textStyle: TextStyle(fontSize: 14),
//                         combine: ItemTagsCombine.imageOrIconOrText,
//                         removeButton: ItemTagsRemoveButton(onRemoved: () {
//                           setState(() {
//                             // tag.removeAt(index);
//                             tags.removeAt(index);
//                           });
//                           return true;
//                         }),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               RaisedButton(
//                 elevation: 10,
//                 onPressed: () {},
//                 color: Colors.teal[700],
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Text(
//                   'Create',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
