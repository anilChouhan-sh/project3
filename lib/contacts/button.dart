import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskarta/Firebase/Providers/userProviders.dart';
import './contacts.dart';

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Center(
        child: RaisedButton(
      child: Text('Press me'),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (v) => MyContacts()),
      ),
    ));
  }
}
