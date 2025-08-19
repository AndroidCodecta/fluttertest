import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/recibo.dart';

class ReciboDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertarRecibo(Recibo recibo) async {
    final db = await _dbHelper.database;
    return await db.insert('recibo', recibo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Recibo>> obtenerRecibos() async {
    final db = await _dbHelper.database;
    final maps = await db.query('recibo');
    return List.generate(maps.length, (i) => Recibo.fromMap(maps[i]));
  }

  Future<Recibo?> obtenerReciboPorId(int id) async {
    final db = await _dbHelper.database;
    final maps =
        await db.query('recibo', where: 'id_recibo = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Recibo.fromMap(maps.first);
    return null;
  }

  Future<int> actualizarRecibo(Recibo recibo) async {
    final db = await _dbHelper.database;
    return await db.update('recibo', recibo.toMap(),
        where: 'id_recibo = ?', whereArgs: [recibo.idRecibo]);
  }

  Future<int> eliminarRecibo(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('recibo', where: 'id_recibo = ?', whereArgs: [id]);
  }
}
