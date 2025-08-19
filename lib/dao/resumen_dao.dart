import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/resumen.dart';

class ResumenDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertarResumen(Resumen resumen) async {
    final db = await _dbHelper.database;
    return await db.insert('resumen', resumen.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Resumen>> obtenerResumenes() async {
    final db = await _dbHelper.database;
    final maps = await db.query('resumen');
    return List.generate(maps.length, (i) => Resumen.fromMap(maps[i]));
  }

  Future<Resumen?> obtenerResumenPorId(int id) async {
    final db = await _dbHelper.database;
    final maps =
        await db.query('resumen', where: 'id_resumen = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Resumen.fromMap(maps.first);
    return null;
  }

  Future<int> actualizarResumen(Resumen resumen) async {
    final db = await _dbHelper.database;
    return await db.update('resumen', resumen.toMap(),
        where: 'id_resumen = ?', whereArgs: [resumen.idResumen]);
  }

  Future<int> eliminarResumen(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('resumen', where: 'id_resumen = ?', whereArgs: [id]);
  }
}
