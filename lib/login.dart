import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:epicture/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void login() async {

    var response = await http.get(
       Uri.parse('https://api.imgur.com/3/image/T0IBWsL'),
      headers: {'Authorization': 'Client-ID ' + client_id},
    );

    final repStr = jsonDecode(response.body);

    print(repStr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF141518),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Image.asset('assets/access-logo.png'),
            Text(
              "Imgur",
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Welcome To the Application",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 170),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2c2f34),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 70, horizontal: 135),
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF1bb76e), // background
                            onPrimary: Colors.white, // foreground
                            textStyle: TextStyle(fontSize: 18),
                            minimumSize: Size(150, 45),
                          ),
                          onPressed: login,
                          child: Text(
                            'Login',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2c2f34), // background
                            onPrimary: Colors.white, // foreground
                            textStyle: TextStyle(fontSize: 18),
                            minimumSize: Size(150, 45),
                          ),
                          onPressed: login,
                          child: Text(
                            'Register',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
