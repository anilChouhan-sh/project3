// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import './project.dart';
// import 'create_project.dart';

// class Homepage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           floatingActionButton: Builder(
//             builder: (context) => Container(
//               height: 70,
//               width: 70,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Create_project(),
//                       ));
//                 },
//                 backgroundColor: Colors.blueGrey[100],
//                 splashColor: Colors.indigoAccent[400],
//                 child: Icon(
//                   CupertinoIcons.plus,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ),
//           body: NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                   expandedHeight: 200.0,
//                   floating: true,
//                   pinned: false,
//                   backgroundColor: Colors.blue,
//                   flexibleSpace: FlexibleSpaceBar(
//                       titlePadding: EdgeInsets.only(bottom: 175),
//                       centerTitle: true,
//                       title: Text("APP NAME",
//                           style: TextStyle(
//                             color: Colors.teal[700],
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16.0,
//                           )),
//                       background: Image.asset(
//                         "image/task.jpg",
//                         fit: BoxFit.cover,
//                       )),
//                 ),
//               ];
//             },
//             body: Container(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 15, top: 15),
//                     child: RichText(
//                       text: TextSpan(
//                         text: 'Hello, ',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 30,
//                         ),
//                         children: <TextSpan>[
//                           TextSpan(
//                               text: 'Anil!',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontStyle: FontStyle.italic)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(top: 20, bottom: 0),
//                     child: ButtonBar(
//                         alignment: MainAxisAlignment.start,
//                         children: [
//                           RaisedButton(
//                             elevation: 2,
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                             onPressed: () {},
//                             child: Text("ALL"),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                             ),
//                             color: Colors.white54,
//                             splashColor: Colors.indigo[400],
//                           ),
//                           RaisedButton(
//                             elevation: 2,
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                             onPressed: () {},
//                             child: Text("Favourites"),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                             ),
//                             color: Colors.white54,
//                             splashColor: Colors.indigo[400],
//                           ),
//                           RaisedButton(
//                             elevation: 2,
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                             onPressed: () {},
//                             child: Text("Recent"),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                             ),
//                             color: Colors.white54,
//                             splashColor: Colors.indigo[400],
//                           )
//                         ]),
//                   ),
//                   SizedBox(height: 10),
//                   Expanded(
//                       child: ListView.builder(
//                     itemCount: 10,
//                     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 24),
//                     itemBuilder: (context, index) {
//                       return new Project();
//                     },
//                   ))
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
