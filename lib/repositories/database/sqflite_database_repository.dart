
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qr_scanner_sqlite/models/scan_model.dart';
import 'package:qr_scanner_sqlite/repositories/database/database_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseRepository implements DatabaseRepository{

  static late final Database _database; 

  static Future<void> init() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'ScansDB.db' );

    print( path );

    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tipo TEXT,
            valor TEXT
          );
        ''');
      }
    );
  }

  static Future<void> dispose() async{
    await _database.close();
  }

  @override
  Future<List<ScanModel>> loadAllScanner() async{
    final data = await _database.query('Scans');

    return data.map((e) => ScanModel.fromJson(e)).toList();
  }
  
  @override
  Future<void> insertNewValue(String tipo, String valor) async{
    await _database.insert("Scans", {
      'tipo': tipo,
      'valor': valor
    });
  }

}