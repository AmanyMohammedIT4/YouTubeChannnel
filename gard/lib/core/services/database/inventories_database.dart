
import 'package:gard/constants.dart';
import 'package:gard/model/inventory_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InventoriesDatabaseHelper{
  InventoriesDatabaseHelper._();
  static final InventoriesDatabaseHelper db = InventoriesDatabaseHelper._();
  static Database? _database;


  Future<Database> get database async{
    if(_database != null) return _database!;

    _database= await initDB();
    return _database!;
  }
  
  Future<Database> initDB() async{
      String path = join(await getDatabasesPath(),'Inventories.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
      // the query
      await db.execute('''
        CREATE TABLE $tableInventory (
          $columnInvName TEXT NOT NULL,
          $columnInvNumber INT NOT NULL,
          $columnInvId TEXT NOT NULL)
      ''');
    });
  }

Future<List<InventoryModel>> getAllInventories()async{
   var dbClient = await database;
   List<Map> maps = await dbClient.query(tableInventory);

   List<InventoryModel> list = maps.isNotEmpty 
    ?
    maps.map((loc) => InventoryModel.fromJson(loc)).toList()
    : [];

    return list;
}

}