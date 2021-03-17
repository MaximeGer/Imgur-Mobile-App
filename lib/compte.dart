import 'dart:convert';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComptePage extends StatefulWidget {
  ComptePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ComptePageState createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            //color: Color(0xFF141518),
            ),
        child: Column(
          children: <Widget>[
            Text("Compte"),
          ],
        ),
      ),
    );
  }
}
