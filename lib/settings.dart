import 'package:flutter/material.dart';
import 'package:epicture/imports.dart';
import 'package:epicture/login.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1bb76e),
      ),
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
                    "Vous etes sur a page settings",
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
