import 'dart:async';
import 'package:flutter/material.dart';
import 'package:epicture/main.dart';
import 'package:epicture/home.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void dispose() {
    _onDestroy.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print(state.url);
      if (state.url.startsWith("https://imgur.com/?state=DEV") ||
          state.url.startsWith("https://m.imgur.com/?state=DEV")) {
        RegExp regExp = new RegExp(r"#access_token=(.*)");
        token = regExp.firstMatch(state.url)?.group(1);
        token = token.split("&")[0];
        print("token $token");
        flutterWebviewPlugin.close();
        Navigator.of(context).pop(true);
      }
    });
  }

  void login() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => new WebviewScaffold(
            url: "https://api.imgur.com/oauth2/authorize?client_id=" +
                client_id +
                "&response_type=token&state=DEV",
            appBar: new AppBar(title: new Text("Login to Imgur...")))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    //color: Color(0xFF141518),
                    ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 115,
                    ),
                    Image.asset('assets/access-logo.png'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome To the Application",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 160),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2c2f34),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 85,
                              horizontal: 120,
                            ),
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
            ],
          ),
        ));
  }
}
