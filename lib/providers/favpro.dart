import 'package:flutter/foundation.dart';
import 'package:flutter_db/database/favorite_db.dart';
import 'package:flutter_db/models/Favorite.dart';


class Favoriteprovider with ChangeNotifier{
  List<Favorite> fav = [];

  //ดึงข้อมูล
  List<Favorite> getFavorite() {
    return fav;
  }

  void initData() async{
    var db = FavDB(dbName: "fav.db");
    fav = await db.loadAllData();
    notifyListeners();
  }

  void addFavorite(Favorite favor) async {
    //var db = await FavDB(dbName: "fav.db").openDatabase();
    //print(db);

    var db = FavDB(dbName: "fav.db");
    //save info
    await db.InsertData(favor);

    //pull data
    fav = await db.loadAllData();
    //แจ้งเตือน consumer
    notifyListeners();
  }


}
    