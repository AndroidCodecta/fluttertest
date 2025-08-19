import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/carrito.dart';

class ProductoCarritoDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertarProductoCarrito(ProductoCarrito producto) async {
    final db = await _dbHelper.database;
    return await db.insert('producto_carrito', producto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductoCarrito>> obtenerProductosCarrito() async {
    final db = await _dbHelper.database;
    final maps = await db.query('producto_carrito');
    return List.generate(maps.length, (i) => ProductoCarrito.fromMap(maps[i]));
  }

  Future<ProductoCarrito?> obtenerProductoCarritoPorId(int id) async {
    final db = await _dbHelper.database;
    final maps = await db
        .query('producto_carrito', where: 'id_p_carrito = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return ProductoCarrito.fromMap(maps.first);
    return null;
  }

  Future<int> actualizarProductoCarrito(ProductoCarrito producto) async {
    final db = await _dbHelper.database;
    return await db.update('producto_carrito', producto.toMap(),
        where: 'id_p_carrito = ?', whereArgs: [producto.idPCarrito]);
  }

  Future<int> eliminarProductoCarrito(int id) async {
    final db = await _dbHelper.database;
    return await db
        .delete('producto_carrito', where: 'id_p_carrito = ?', whereArgs: [id]);
  }
}
