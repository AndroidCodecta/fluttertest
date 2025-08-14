import '../database/database_helper.dart';
import '../models/recibo.dart';

class ReciboDao {
  static const String tableName = 'recibo';

  // Crear recibo
  Future<int> insertRecibo(Recibo recibo) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(tableName, recibo.toMap());
  }

  // Obtener todos los recibos
  Future<List<Recibo>> getAllRecibos() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Recibo.fromMap(maps[i]);
    });
  }

  // Obtener recibos por cliente
  Future<List<Recibo>> getRecibosPorCliente(int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_clientes = ?',
      whereArgs: [idCliente],
      orderBy: 'fecha DESC',
    );
    return List.generate(maps.length, (i) {
      return Recibo.fromMap(maps[i]);
    });
  }

  // Obtener recibo por ID
  Future<Recibo?> getReciboById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_recibo = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Recibo.fromMap(maps.first);
    }
    return null;
  }

  // Obtener recibos por rango de fechas
  Future<List<Recibo>> getRecibosPorFechas(
    DateTime fechaInicio,
    DateTime fechaFin,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'fecha BETWEEN ? AND ?',
      whereArgs: [
        fechaInicio.toIso8601String().split('T')[0],
        fechaFin.toIso8601String().split('T')[0],
      ],
      orderBy: 'fecha DESC',
    );
    return List.generate(maps.length, (i) {
      return Recibo.fromMap(maps[i]);
    });
  }

  // Actualizar recibo
  Future<int> updateRecibo(Recibo recibo) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      tableName,
      recibo.toMap(),
      where: 'id_recibo = ?',
      whereArgs: [recibo.idRecibo],
    );
  }

  // Eliminar recibo
  Future<int> deleteRecibo(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(tableName, where: 'id_recibo = ?', whereArgs: [id]);
  }

  // Obtener último número de recibo
  Future<String> getUltimoNumeroRecibo() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      tableName,
      columns: ['numero_recibo'],
      orderBy: 'id_recibo DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['numero_recibo'] as String;
    }
    return '0000'; // Número inicial si no hay recibos
  }

  // Calcular total de ventas por fecha
  Future<double> calcularTotalVentasPorFecha(DateTime fecha) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      '''
      SELECT SUM(total) as total_ventas 
      FROM $tableName 
      WHERE fecha = ?
    ''',
      [fecha.toIso8601String().split('T')[0]],
    );

    final total = result.first['total_ventas'];
    return (total as num?)?.toDouble() ?? 0.0;
  }

  // Contar recibos por cliente
  Future<int> contarRecibosPorCliente(int idCliente) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName WHERE id_clientes = ?',
      [idCliente],
    );
    return result.first['count'] as int;
  }
}
