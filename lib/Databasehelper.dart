

import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {

  static Database? _db ;

  Future<Database?> get db async {
    if(_db != null){
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory() ;
    String path = join(documentDirectory.path , 'cart.db');
    var db = await openDatabase(path , version: 1 , onCreate: _onCreate,);
    return db ;
  }

  _onCreate (Database db , int version )async{
    await db.execute('''
        CREATE TABLE tableName(ItemId NVARCHAR(30),
        ItemName NVARCHAR(70), ItemUrduName NVARCHAR(70), TradePrice FLOAT)
        
        '''


    );

  }






}