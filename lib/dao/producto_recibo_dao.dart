import '../database/database_helper.dart';
import '../models/producto.dart';

class ProductoReciboDao {
  static const String tableName = 'producto_recibo';

  // Agregar producto al recibo
  Future<int> insertProductoRecibo(Producto producto, int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    final Map<String, dynamic> data = producto.toReciboMap();
    data['id_recibo'] = idRecibo;
    data.remove('id_p_recibo'); // Permitir autoincremento
    return await db.insert(tableName, data);
  }

  // Obtener productos de un recibo
  Future<List<Producto>> getProductosReciboPorRecibo(int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_recibo = ?',
      whereArgs: [idRecibo],
    );
    return List.generate(maps.length, (i) {
      return Producto.fromMap(maps[i]);
    });
  }

  // Obtener producto del recibo por ID
  Future<Producto?> getProductoReciboById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_p_recibo = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Producto.fromMap(maps.first);
    }
    return null;
  }

  // Actualizar producto en recibo
  Future<int> updateProductoRecibo(Producto producto, int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    final Map<String, dynamic> data = producto.toReciboMap();
    data['id_recibo'] = idRecibo;
    return await db.update(
      tableName,
      data,
      where: 'id_p_recibo = ?',
      whereArgs: [producto.idProducto],
    );
  }

  // Eliminar producto del recibo
  Future<int> deleteProductoRecibo(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id_p_recibo = ?',
      whereArgs: [id],
    );
  }

  // Eliminar todos los productos de un recibo
  Future<int> deleteProductosDeRecibo(int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id_recibo = ?',
      whereArgs: [idRecibo],
    );
  }

  // Calcular subtotal de un recibo
  Future<double> calcularSubtotalRecibo(int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      '''
      SELECT SUM(precio * cantidad) as subtotal 
      FROM $tableName 
      WHERE id_recibo = ?
    ''',
      [idRecibo],
    );

    final subtotal = result.first['subtotal'];
    return (subtotal as num?)?.toDouble() ?? 0.0;
  }

  // Calcular total de descuentos de un recibo
  Future<double> calcularDescuentosRecibo(int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      '''
      SELECT SUM(COALESCE(descuento, 0) * cantidad) as total_descuentos 
      FROM $tableName 
      WHERE id_recibo = ?
    ''',
      [idRecibo],
    );

    final descuentos = result.first['total_descuentos'];
    return (descuentos as num?)?.toDouble() ?? 0.0;
  }

  // Contar productos en un recibo
  Future<int> contarProductosEnRecibo(int idRecibo) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName WHERE id_recibo = ?',
      [idRecibo],
    );
    return result.first['count'] as int;
  }
}
