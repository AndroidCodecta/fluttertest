import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/producto_recibo.dart';

class ProductoReciboDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertarProductoRecibo(ProductoRecibo producto) async {
    final db = await _dbHelper.database;
    return await db.insert('producto_recibo', producto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductoRecibo>> obtenerProductosRecibo() async {
    final db = await _dbHelper.database;
    final maps = await db.query('producto_recibo');
    return List.generate(maps.length, (i) => ProductoRecibo.fromMap(maps[i]));
  }

  Future<ProductoRecibo?> obtenerProductoReciboPorId(int id) async {
    final db = await _dbHelper.database;
    final maps = await db
        .query('producto_recibo', where: 'id_p_recibo = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return ProductoRecibo.fromMap(maps.first);
    return null;
  }

  Future<int> actualizarProductoRecibo(ProductoRecibo producto) async {
    final db = await _dbHelper.database;
    return await db.update('producto_recibo', producto.toMap(),
        where: 'id_p_recibo = ?', whereArgs: [producto.idPRecibo]);
  }

  Future<int> eliminarProductoRecibo(int id) async {
    final db = await _dbHelper.database;
    return await db
        .delete('producto_recibo', where: 'id_p_recibo = ?', whereArgs: [id]);
  }
}
