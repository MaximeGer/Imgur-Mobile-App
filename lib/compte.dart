import 'package:flutter/material.dart';
import 'package:epicture/imports.dart';

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
      body: Container(
        child: FutureBuilder<List<dynamic>>(
            future: fetch('https://api.imgur.com/3/account/me/images',
                {"Authorization": "Bearer $token"}),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && token.isNotEmpty) {
                // snapshot.data.removeWhere((i) => ((i != null &&
                //         i["images"].length != 0 &&
                //         i["images"][0]["type"].contains('mp4')) ||
                //     (i["cover"] == null)));
                return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF2c2f34),
                              ),
                              child: Column(children: <Widget>[
                                Image.network(links(snapshot.data[index])),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 5,
                                  ),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.message),
                                            color: Color(0xFF8e9094),
                                            iconSize: 24.0,
                                            onPressed: () {},
                                          ),
                                          Text(
                                            comment(snapshot.data[index]),
                                            style: TextStyle(
                                                color: Color(0xFF8e9094)),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.star),
                                        color: Color(0xFF8e9094),
                                        iconSize: 24.0,
                                        onPressed: () {},
                                      ),
                                      Flex(
                                        direction: Axis.vertical,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.favorite),
                                            color: Color(0xFF8e9094),
                                            iconSize: 24.0,
                                            onPressed: () {},
                                          ),
                                          Text(
                                            likes(snapshot.data[index]),
                                            style: TextStyle(
                                                color: Color(0xFF8e9094)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ])));
                    });
              } else
                return Card(
                    child: Text("Pas d'images retrouvées. Connectez-vous!!!"));
            }),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: <Widget>[
  //           Visibility(
  //             visible: token.isEmpty,
  //             child: Column(
  //               children: <Widget>[
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Color(0xFF1bb76e), // background
  //                     onPrimary: Colors.white, // foreground
  //                     textStyle: TextStyle(fontSize: 18),
  //                     minimumSize: Size(150, 45),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       new MaterialPageRoute(
  //                           builder: (context) => LoginPage()),
  //                     );
  //                   },
  //                   child: Text(
  //                     'Login',
  //                   ),
  //                 )
  //               ],
  //             ),
  //             replacement: Column(
  //               children: <Widget>[
  //                 Text(
  //                   "Vous etes sur a page compte",
  //                   style: TextStyle(color: Colors.white, fontSize: 18),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
