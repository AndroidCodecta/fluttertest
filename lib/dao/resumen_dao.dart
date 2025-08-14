import '../database/database_helper.dart';
import '../models/resumen.dart';

class ResumenDao {
  static const String tableName = 'resumen';

  // Crear resumen
  Future<int> insertResumen(Resumen resumen) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(tableName, resumen.toMap());
  }

  // Obtener todos los resúmenes
  Future<List<Resumen>> getAllResumenes() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Resumen.fromMap(maps[i]);
    });
  }

  // Obtener resúmenes por usuario
  Future<List<Resumen>> getResumenesPorUsuario(int idUsuario) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_usuario = ?',
      whereArgs: [idUsuario],
      orderBy: 'id_resumen DESC',
    );
    return List.generate(maps.length, (i) {
      return Resumen.fromMap(maps[i]);
    });
  }

  // Obtener resumen por ID
  Future<Resumen?> getResumenById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_resumen = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Resumen.fromMap(maps.first);
    }
    return null;
  }

  // Obtener último resumen de un usuario
  Future<Resumen?> getUltimoResumenPorUsuario(int idUsuario) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_usuario = ?',
      whereArgs: [idUsuario],
      orderBy: 'id_resumen DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return Resumen.fromMap(maps.first);
    }
    return null;
  }

  // Actualizar resumen
  Future<int> updateResumen(Resumen resumen) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      tableName,
      resumen.toMap(),
      where: 'id_resumen = ?',
      whereArgs: [resumen.idResumen],
    );
  }

  // Eliminar resumen
  Future<int> deleteResumen(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(tableName, where: 'id_resumen = ?', whereArgs: [id]);
  }

  // Actualizar o crear resumen diario para un usuario
  Future<int> actualizarResumenDiario(
    int idUsuario, {
    int? numeroClientes,
    int? visitados,
    int? exitosos,
    int? noExitosos,
    int? pendiente,
    double? montoTotal,
  }) async {
    final resumenExistente = await getUltimoResumenPorUsuario(idUsuario);

    if (resumenExistente != null) {
      // Actualizar resumen existente
      final resumenActualizado = Resumen(
        idResumen: resumenExistente.idResumen,
        numeroClientes: numeroClientes ?? resumenExistente.numeroClientes,
        visitados: visitados ?? resumenExistente.visitados,
        exitosos: exitosos ?? resumenExistente.exitosos,
        noExitosos: noExitosos ?? resumenExistente.noExitosos,
        pendiente: pendiente ?? resumenExistente.pendiente,
        montoTotal: montoTotal ?? resumenExistente.montoTotal,
        idUsuario: idUsuario,
      );
      return await updateResumen(resumenActualizado);
    } else {
      // Crear nuevo resumen
      final nuevoResumen = Resumen(
        numeroClientes: numeroClientes ?? 0,
        visitados: visitados ?? 0,
        exitosos: exitosos ?? 0,
        noExitosos: noExitosos ?? 0,
        pendiente: pendiente ?? 0,
        montoTotal: montoTotal ?? 0.0,
        idUsuario: idUsuario,
      );
      return await insertResumen(nuevoResumen);
    }
  }

  // Calcular estadísticas automáticamente para un usuario
  Future<Resumen> calcularEstadisticasUsuario(int idUsuario) async {
    final db = await DatabaseHelper.instance.database;

    // Contar clientes del usuario
    final clientesResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM Clientes WHERE id_usuario = ?',
      [idUsuario],
    );
    final numeroClientes = clientesResult.first['count'] as int;

    // Calcular monto total de recibos
    final montoResult = await db.rawQuery(
      '''
      SELECT SUM(r.total) as monto_total 
      FROM recibo r 
      INNER JOIN Clientes c ON r.id_clientes = c.id_clientes 
      WHERE c.id_usuario = ?
    ''',
      [idUsuario],
    );
    final montoTotal =
        (montoResult.first['monto_total'] as num?)?.toDouble() ?? 0.0;

    return Resumen(
      numeroClientes: numeroClientes,
      visitados:
          0, // Estos valores deberían calcularse según la lógica de negocio
      exitosos: 0,
      noExitosos: 0,
      pendiente: 0,
      montoTotal: montoTotal,
      idUsuario: idUsuario,
    );
  }
}
