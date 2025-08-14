import '../database/database_helper.dart';
import '../models/producto.dart';

class ProductoCarritoDao {
  static const String tableName = 'producto_carrito';

  // Agregar producto al carrito
  Future<int> insertProductoCarrito(Producto producto, int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final Map<String, dynamic> data = producto.toCarritoMap();
    data['id_clientes'] = idCliente;
    data.remove('id_p_carrito'); // Permitir autoincremento
    return await db.insert(tableName, data);
  }

  // Obtener productos del carrito por cliente
  Future<List<Producto>> getProductosCarritoPorCliente(int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_clientes = ?',
      whereArgs: [idCliente],
    );
    return List.generate(maps.length, (i) {
      return Producto.fromMap(maps[i]);
    });
  }

  // Obtener producto del carrito por ID
  Future<Producto?> getProductoCarritoById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_p_carrito = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Producto.fromMap(maps.first);
    }
    return null;
  }

  // Actualizar producto en carrito
  Future<int> updateProductoCarrito(Producto producto, int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final Map<String, dynamic> data = producto.toCarritoMap();
    data['id_clientes'] = idCliente;
    return await db.update(
      tableName,
      data,
      where: 'id_p_carrito = ?',
      whereArgs: [producto.idProducto],
    );
  }

  // Eliminar producto del carrito
  Future<int> deleteProductoCarrito(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id_p_carrito = ?',
      whereArgs: [id],
    );
  }

  // Limpiar carrito de un cliente
  Future<int> limpiarCarritoCliente(int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id_clientes = ?',
      whereArgs: [idCliente],
    );
  }

  // Calcular total del carrito
  Future<double> calcularTotalCarrito(int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      '''
      SELECT SUM((precio - COALESCE(descuento, 0)) * cantidad) as total 
      FROM $tableName 
      WHERE id_clientes = ?
    ''',
      [idCliente],
    );

    final total = result.first['total'];
    return (total as num?)?.toDouble() ?? 0.0;
  }

  // Contar productos en carrito
  Future<int> contarProductosEnCarrito(int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName WHERE id_clientes = ?',
      [idCliente],
    );
    return result.first['count'] as int;
  }
}
