import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epicture',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            // ElevatedButton(
            // style: ElevatedButton.styleFrom(
            //     primary: Color(0xFF191919), // background
            //     onPrimary: Color(0xFF4f4f4f), // foreground
            //   ),
            //   onPressed: () {
            //     // Respond to button press
            //   },
            //   child: Text('CONTAINED BUTTON'),
            // ),
          ],
        ),
      ),
    );
  }
}
