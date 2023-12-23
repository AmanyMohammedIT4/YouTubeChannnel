
import 'package:gard/constants.dart';
import 'package:gard/model/query_inventory_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScanInventoryDatabaseHelper{
  ScanInventoryDatabaseHelper.internal();
  static final ScanInventoryDatabaseHelper instance =
      new ScanInventoryDatabaseHelper.internal();
  factory ScanInventoryDatabaseHelper() => instance;



  ScanInventoryDatabaseHelper._();
  static final ScanInventoryDatabaseHelper db = ScanInventoryDatabaseHelper._();
  static Database? _database;


Future<Database> get database async{
    if(_database != null) return _database!;

    _database= await initDb();
    return _database!;
  }

Future<Database> initDb() async{
      String path = join(await getDatabasesPath(),'ScanBarcodeInventoryDb.db' );

      return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async{
          await db.execute('''
            CREATE TABLE $tableScanInventory (
            $columnNameProInv TEXT NOT NULL,
            $columnBarcodeInv TEXT NOT NULL,
            $columnEmailInv TEXT NOT NULL,
            $columnNameInv TEXT NOT NULL,
            $columnDateInv DATETIME NOT NULL,
            $columnCountInv INT NOT NULL
            )
        ''');
        }
      );
    }

Future<List<QueryInventoryModel>> getAllScanInventory()async{
   var dbClient = await database;
   List<Map> maps = await dbClient.query(tableScanInventory);

   List<QueryInventoryModel> list = maps.isNotEmpty 
    ?
    maps.map((scan) => QueryInventoryModel.fromJson(scan)).toList()
    : [];

    return list;
}

Future<int> insertData(String nameProductValue,
                       String barcodeValue, String email, 
                       String nameInv, String date, int quantity) async {
  Database? mydb = await database;
  mydb.isOpen;
  String insertQuery = '''
    INSERT INTO $tableScanInventory ($columnNameProInv, $columnBarcodeInv, $columnEmailInv, $columnNameInv, $columnDateInv, $columnCountInv) 
    VALUES (?, ?, ?, ?, ?, ?)
  ''';
  int response = await mydb.rawInsert(insertQuery, [nameProductValue, barcodeValue, email, nameInv, date, quantity]);
  return response;
} 

// Future<int> deleteTable(String tableName) async {
//   Database db = await this.database;
  
//   if (db.isOpen) {
//     var result = await db.delete(tableName);
//     return result;
//   } else {
//     throw Exception("Database is closed");
//   }
// }
Future<int> deleteTable(String tableName) async {
    Database db = await this.database;
    var result = await db.rawDelete("DELETE FROM $tableName");
    return result;
 
  }

// Future<int> deleteTable(String tableName) async {
//   Database db = await this.database;
  
//   if (db.isOpen) {
//     var result = await db.delete(tableName);
//     return result;
//   } else {
//     throw Exception("Database is closed");
//   }
// }
  
Future<List<Map<String, dynamic>>> getTableData(String tablename) async {
    Database db = await this.database;
    var result = await db.query(tablename);
    return result;
  }

  Future<List<Map<String, dynamic>>> retrieveDataFromSqlite() async {
  Database database =  await initDb();

  // استرجع البيانات من الجدول
  List<Map<String, dynamic>> data = await database.query(tableScanInventory);

  // أغلق قاعدة البيانات
  // await database.close();

  return data;
}


}