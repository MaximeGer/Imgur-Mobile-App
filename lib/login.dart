import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onPressed: () {
                            // Respond to button press
                          },
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
                          onPressed: () {
                            // Respond to button press
                          },
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
