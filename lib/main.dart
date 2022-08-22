import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

Map<String, dynamic> datafile = {};

void main() async {
  setPathUrlStrategy();
  var data = Uri(path: "assets/assets/Content.json");
  var dt = await http.read(data);
  datafile = jsonDecode(dt.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static Route<dynamic> _genroute(settings) {
    return MaterialPageRoute(builder: (context) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _genroute,
      title: 'Download Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  List<Widget> MakeTemp() {
    List<Widget> child = [];
    var dt = datafile.keys.toList();
    for (int i = 0; i < dt.length; i++) {
      var cont = datafile[dt[i]];
      if (cont["photo"] == null) {
        continue;
      }
      child.add(Tooltip(
        margin: EdgeInsets.symmetric(horizontal: 25),
        message: dt[i] + "\n" + cont["desc"],
        padding: EdgeInsets.all(8),
        height: 50,
        textStyle: TextStyle(
          color: Colors.black
        ),
        decoration: BoxDecoration(
          color: Colors.white70,

        ),
        child: SizedBox(
          height: 450,
          child: Column(
              mainAxisSize: MainAxisSize.min,
               children: [
                 Image.network(cont["photo"], height: 200,),
                 Padding(padding: EdgeInsets.only(top: 8)),
                 Text(dt[i])
               ],
            ),
        ),
      ));
    };
    return child;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(250),
            child: ColoredBox(
                color: Color.fromRGBO(34, 47, 62, 1),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Moviez",
                              style: GoogleFonts.passeroOne(
                                  color: Colors.white,
                                  fontSize: 50)),
                          SizedBox(
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Search",
                                  filled: true,
                                  labelStyle:
                                      TextStyle(color: Colors.pinkAccent),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide:
                                          BorderSide(color: Colors.pinkAccent)),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.pink, width: 1))),
                            ),
                            width: 200,
                          )
                        ])))),
        body: SingleChildScrollView(

          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              width: Size.infinite.width,
              child: GridView(
                shrinkWrap: true,
                cacheExtent: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width > 1000 ? 5 : 2
                ),
                children: MakeTemp(),
              ),
            ),
          ),
        ),
    bottomNavigationBar: SizedBox(
        width: Size.infinite.width,
        height: 60,
        child: ColoredBox(
          color: Color.fromRGBO(34, 47, 62, 1),
          child: Center(
            child: Text(
              "Movies@" + DateTime.now().year.toString(),
              style: GoogleFonts.akayaKanadaka(
                color: Colors.white,
                   fontSize: 20),
            )),
      ),
      //     padding: EdgeInsets.all(30),
    ),);
  }
}
