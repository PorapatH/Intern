import 'package:flutter/material.dart';
import 'package:flutter_db/providers/favpro.dart';
import 'package:flutter_db/screen/favscreen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'models/Favorite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Favoriteprovider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'รายการโปรด'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    Provider.of<Favoriteprovider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.text_fields),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FavScreen();
                }));
              },
            )
          ],
        ),
        body: Consumer(builder: (context, Favoriteprovider provider, child) {
          var count = provider.fav.length; //นับจำนวนข้อมูล
          if (count < 0) {
            return Center(
              child: Text(
                "ไม่มีรายการโปรด",
                style: TextStyle(fontSize: 30),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Favorite data = provider.fav[index];
                  return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: ListTile(
                                title: Text(data.message),
                                onTap: () {
                                  final FlutterTts tts = FlutterTts();
                                  tts.speak(data.message);
                                  
                                },
                              ),
                            );  
                });
          }
        }));
  }
}
