import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gard/constants.dart';
import 'package:gard/model/items_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemsDatabaseHelper{
  ItemsDatabaseHelper._();
  static final ItemsDatabaseHelper db = ItemsDatabaseHelper._();
  static Database? _database;


  Future<Database> get database async{
    if(_database != null) return _database!;

    _database= await initDB();
    return _database!;
  }
  
  Future<Database> initDB() async{
      String path = join(await getDatabasesPath(),'Product.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
      // the query
      await db.execute('''
        CREATE TABLE $tableProduct (
          $columnName TEXT NOT NULL,
          $columnBarcode TEXT NOT NULL)
      ''');
    });
  }

Future<List<ItemsModle>> getAllProduct()async{
   var dbClient = await database;
   List<Map> maps = await dbClient.query(tableProduct);

   List<ItemsModle> list = maps.isNotEmpty 
    ?
    maps.map((product) => ItemsModle.fromJson(product)).toList()
    : [];

    return list;
}


// مقارنة الباركود المحذوف بين القيم في قاعدة البيانات المحلية وتخزين الاسم والباركود إذا كان هناك تطابق
Future<void> compareBarcodeAndStoreMatchedData(String barcode) async {
  Database localDB = await initDB();
  
  List<Map<String, dynamic>> matchedData = await localDB.query(
    'Product',
    where: 'barcode = ?',
    whereArgs: [barcode],
  );
  
  if (matchedData.isNotEmpty) {
    String name = matchedData[0]['name'];
    
    // تخزين الاسم والباركود في جدول "scanningBarcode" في Firebase
    await FirebaseFirestore.instance
        .collection('scanningBarcode')
        .add({'name': name, 'barcode': barcode});
  }
}

}