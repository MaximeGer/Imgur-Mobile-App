import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/imports.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Future<dynamic> upload(
      String imageUrl, Map<String, String> headersParams) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance(); à implémenter plus tard
    var result = await http.post(Uri.parse('https://api.imgur.com/3/image'),
        headers: headersParams, body: {'image': imageUrl});
    print(json.decode(result.body)['data']);
  }

  PickedFile imageFile;
  var bytesImage;

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
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
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text(
        "No Image Selected",
        style: TextStyle(color: Colors.white),
      );
    } else {
      return Image.file(File(imageFile.path), width: 400, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1bb76e),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF474a51), // background
                  onPrimary: Colors.white, // foreground
                  textStyle: TextStyle(fontSize: 18),
                  minimumSize: Size(150, 45),
                ),
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Select Image"),
              ),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1bb76e), // background
                      onPrimary: Colors.white, // foreground
                      textStyle: TextStyle(fontSize: 18),
                      minimumSize: Size(150, 45),
                    ),
                    onPressed: () {
                      bytesImage =
                          base64.encode(File(imageFile.path).readAsBytesSync());

                      print(bytesImage);
                      print(upload(
                          bytesImage,
                          token.isEmpty
                              ? {"Authorization": "Client-ID $clientId"}
                              : {"Authorization": "Bearer $token"}));
                    },
                    child: Text(
                      'Post Image Url on Imgur',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: <Widget>[
      //       Column(
      //         children: <Widget>[
      //           ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               primary: Color(0xFF1bb76e), // background
      //               onPrimary: Colors.white, // foreground
      //               textStyle: TextStyle(fontSize: 18),
      //               minimumSize: Size(150, 45),
      //             ),
      //             onPressed: () {
      //               print(upload(
      //                   'https://www.serieously.com/wp-content/uploads/2019/05/v9jxsml42we21.jpg',
      //                   {"Authorization": "Bearer $token"}));
      //             },
      //             child: Text(
      //               'Post Image Url on Imgur',
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
