import 'dart:convert';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:epicture/login.dart';

class ComptePage extends StatefulWidget {
  ComptePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ComptePageState createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: token.isEmpty,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1bb76e), // background
                      onPrimary: Colors.white, // foreground
                      textStyle: TextStyle(fontSize: 18),
                      minimumSize: Size(150, 45),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Login',
                    ),
                  )
                ],
              ),
              replacement: Column(
                children: <Widget>[
                  Text(
                    "Vous etes sur a page compte",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
