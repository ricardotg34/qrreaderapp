import 'dart:io';
import 'package:path/path.dart'; //para join
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  //Constructor privado
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

    initDB() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'Scans.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE Scan ('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
            ')'
          );
        }
      );
    }

    // CREAR Registros
    Future<int> nuevoScan(ScanModel nuevoScan) async{
      final db = await database;
      final int res = await db.insert('Scan', nuevoScan.toJson());
      return res;
    }

    // OBTENER Un registro por id
    Future<ScanModel> getScanId(int id) async {
      final db = await database;
      //El signo de interrogacion significa que ahi va un argumento
      final res = await db.query('Scan', where: 'id = ?', whereArgs: [id]);
      return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
    }
    //Regresar todos los Scans
    Future<List<ScanModel>> getAllScans() async {
      final db = await database;
      //El signo de interrogacion significa que ahi va un argumento
      final res = await db.query('Scan');
      List<ScanModel> list = res.isNotEmpty
      ? res.map((scan) => ScanModel.fromJson(scan)).toList()
      : [];
      return list;
    }

    //Regresar todos los Scans que coincidan con el tipo
    Future<List<ScanModel>> getScansByType(String tipo) async {
      final db = await database;
      //El signo de interrogacion significa que ahi va un argumento
      final res = await db.query('Scan', where: 'tipo = ?', whereArgs: [tipo]);
      List<ScanModel> list = res.isNotEmpty
      ? res.map((scan) => ScanModel.fromJson(scan)).toList()
      : [];
      return list;
    }

    //Actualizar Registros
    Future<int> updateScan(ScanModel nuevoScan) async {
      final db = await database;
      final res = await db.update('Scan', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);
      return res;
    }

    // Borrar Registros
    Future<int> deleteScan(int id) async {
      final db = await database;
      final res = await db.delete('Scan', where: 'id = ?', whereArgs: [id]);
      return res;
    }

    // Borrar Registros
    Future<int> deleteAll() async {
      final db = await database;
      final res = await db.delete('Scan');
      return res;
    }
}