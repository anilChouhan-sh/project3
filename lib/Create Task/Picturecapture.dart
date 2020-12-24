import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Picturecapture extends StatefulWidget {
  @override
  _PicturecaptureState createState() => _PicturecaptureState();
}

class _PicturecaptureState extends State<Picturecapture> {
  File imageFile;
  _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile, width: 100, height: 100);
    } else {
      return Text("Please select an image");
    }
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text("From where do you want to take the photo?"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(left: 0, top: 25),
      child: Column(
        children: <Widget>[
          // _setImageView(),
          Icon(
            Icons.add_a_photo_rounded,
            color: Colors.teal[700],
            size: 30,
          ),
        ],
      ),
      onPressed: () {
        _showSelectionDialog(context);
        print("button pressed");
      },
    );
  }
}
