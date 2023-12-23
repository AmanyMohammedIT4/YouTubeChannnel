
import 'package:gard/constants.dart';
import 'package:gard/model/locations_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocationsDatabaseHelper{
     LocationsDatabaseHelper.internal();
  static final LocationsDatabaseHelper instance =
      new LocationsDatabaseHelper.internal();
  factory LocationsDatabaseHelper() => instance;


  LocationsDatabaseHelper._();
  static final LocationsDatabaseHelper db = LocationsDatabaseHelper._();
  static Database? _database;


  Future<Database> get database async{
    if(_database != null) return _database!;

    _database= await initDB();
    return _database!;
  }
  
  Future<Database> initDB() async{
      String path = join(await getDatabasesPath(),'Locations.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
      await db.execute('''
        CREATE TABLE $tableLocation (
          $columnLocName TEXT NOT NULL,
          $columnLocNumber INT NOT NULL,
          $columnLocId TEXT NOT NULL)
      ''');
    });
  }

Future<List<LocationsModel>> getAllLocations()async{
   var dbClient = await database;
   List<Map> maps = await dbClient.query(tableLocation);

   List<LocationsModel> list = maps.isNotEmpty 
    ?
    maps.map((loc) => LocationsModel.fromJson(loc)).toList()
    : [];

    return list;
}

  Future<List<LocationsModel>> fetchOfflineData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> results = await db.query(tableLocation);
    await db.close();

    final List<LocationsModel> offlineData = results.map((Map<String, dynamic> map) {
      return LocationsModel.fromJson(map);
    }).toList();

    return offlineData;
  }
}