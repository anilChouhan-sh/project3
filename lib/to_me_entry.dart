import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Firebase/entry.dart';
import 'Firebase/entryprovider.dart';
import 'Firebase/firestore.dart';

class to_me_entry extends StatefulWidget {
  final Entry entry;

  to_me_entry({this.entry});
  @override
  _to_me_entryState createState() => _to_me_entryState();
}

class _to_me_entryState extends State<to_me_entry> {
  final entryController = TextEditingController();
  final entryID = TextEditingController();
  @override
  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider = Provider.of<Entryprovider>(context, listen: false);
    if (widget.entry != null) {
      //Edit
      entryController.text = widget.entry.title;
      entryID.text = widget.entry.id.toString();

      entryProvider.loadAll(widget.entry);
    } else {
      //Add
      entryProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<Entryprovider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: Text('create')),
        body: Column(
          children: [
            TextField(
              onChanged: (String value) => entryProvider.changetitle = value,
              controller: entryController,
            ),
            TextField(
              //onChanged: (String value) => entryProvider.changeid = value,
              controller: entryID,
            ),
            RaisedButton(
              child: Text('SAVE'),
              onPressed: () {
                entryProvider.saveEntry();
              },
            )
          ],
        ));
  }
}
