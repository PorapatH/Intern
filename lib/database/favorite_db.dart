import 'dart:io';
import 'package:flutter_db/models/Favorite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class FavDB {
  //บริการเกี่ยวกับฐานข้อมูล

  String dbName; //เก็บชื่อฐานข้อมูล

  //ถ้ายังไม่ถูกสร้างให้สร้าง
  //ถ้าสร้างแล้วให้ทำการเปิด
  FavDB({required this.dbName});

  // user A,B,C
  //find user's path: user/a, user/b
  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จัดเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    //create database
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //save info
  Future<int> InsertData(Favorite favor) async {
    //save to database store

    //create store
    var db = await openDatabase();
    var store = intMapStoreFactory.store("message");

    //keep in JSON
    var keyID = store.add(db, {"message": favor.message});
    //await store.delete(db); >try<
    db.close();
    return keyID;
  }

  //pulldata
   Future<List<Favorite>> loadAllData() async{
    var db = await openDatabase();
    var store = intMapStoreFactory.store("message");
    var snapshot = await store.find(db, finder: Finder(sortOrders: [SortOrder(Field.key,false)]));
    var favList = <Favorite>[];
    //pull one by one
    for(var record in snapshot){
      favList.add(Favorite(message: record["message"].toString()));
    } 
    return favList;
  }
}
