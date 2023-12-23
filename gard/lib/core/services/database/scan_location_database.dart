
import 'package:gard/constants.dart';
import 'package:gard/model/query_location_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScanLocationDatabaseHelper{
   ScanLocationDatabaseHelper.internal();
  static final ScanLocationDatabaseHelper instance =
      new ScanLocationDatabaseHelper.internal();
  factory ScanLocationDatabaseHelper() => instance;


  ScanLocationDatabaseHelper._();
  static final ScanLocationDatabaseHelper db = ScanLocationDatabaseHelper._();
  static Database? _database;


  Future<Database> get database async{
    if(_database != null) return _database!;

    _database= await initDb();
    return _database!;
  }

  Future<Database> initDb() async{
      String path = join(await getDatabasesPath(),'ScanBarcodeLocationDb.db' );

      return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async{
          await db.execute('''
            CREATE TABLE $tableScanLocation (
            $columnNameProLoc TEXT NOT NULL,
            $columnBarcodeLoc TEXT NOT NULL,
            $columnEmailLoc TEXT NOT NULL,
            $columnNameLoc TEXT NOT NULL,
            $columnDateLoc DATETIME NOT NULL
            )
        ''');
        }
      );
    }

Future<List<QueryLocationModel>> getAllScanLocation()async{
   var dbClient = await database;
   List<Map> maps = await dbClient.query(tableScanLocation);

   List<QueryLocationModel> list = maps.isNotEmpty 
    ?
    maps.map((scan) => QueryLocationModel.fromJson(scan)).toList()
    : [];

    return list;
}

// Future<int> insertData(String nameProductValue, String barcodeValue, String email, String nameLoc, String date) async {
//   if (database == null) {
//     await initDb();
//   }

//   Database? mydb = await database;
//   String insertQuery = '''
//     INSERT INTO $tableScanLocation ($columnNameProLoc, $columnBarcodeLoc, $columnEmailLoc, $columnNameLoc, $columnDateLoc) 
//     VALUES (?, ?, ?, ?, ?)
//   ''';
//   int response = await mydb.rawInsert(insertQuery, [nameProductValue, barcodeValue, email, nameLoc, date]);
//   return response;
// }

Future<int> insertData(String nameProductValue,
                       String barcodeValue, String email, 
                       String nameLoc, String date) async {
  Database mydb = await database;
  String insertQuery = '''
    INSERT INTO $tableScanLocation ($columnNameProLoc, $columnBarcodeLoc, $columnEmailLoc, $columnNameLoc, $columnDateLoc) 
    VALUES (?, ?, ?, ?, ?)
  ''';
  mydb.isOpen;
  int response = await mydb.rawInsert(insertQuery, [nameProductValue, barcodeValue, email, nameLoc, date]);
  return response;
} 

Future<int> deleteTable(String tableName) async {
    Database db = await this.database;
    // db.isOpen;
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
  
Future<List<Map<String, dynamic>>> retrieveDataFromSqlite() async {
  // افتح قاعدة البيانات
  Database database = await initDb();

  // استرجع البيانات من الجدول
  List<Map<String, dynamic>> data = await database.query(tableScanLocation);

  // أغلق قاعدة البيانات
  // await database.close();

  return data;
}



}