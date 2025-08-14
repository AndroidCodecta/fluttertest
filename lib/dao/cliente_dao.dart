import '../database/database_helper.dart';
import '../models/cliente.dart';

class ClienteDao {
  static const String tableName = 'Clientes';

  // Crear cliente
  Future<int> insertCliente(Cliente cliente) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(tableName, cliente.toMap());
  }

  // Obtener todos los clientes
  Future<List<Cliente>> getAllClientes() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  // Obtener clientes por usuario
  Future<List<Cliente>> getClientesByUsuario(int idUsuario) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_usuario = ?',
      whereArgs: [idUsuario],
    );
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  // Obtener cliente por ID
  Future<Cliente?> getClienteById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_clientes = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cliente.fromMap(maps.first);
    }
    return null;
  }

  // Buscar clientes por nombre
  Future<List<Cliente>> buscarClientesPorNombre(
    String nombre,
    int idUsuario,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'nombre LIKE ? AND id_usuario = ?',
      whereArgs: ['%$nombre%', idUsuario],
    );
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  // Actualizar cliente
  Future<int> updateCliente(Cliente cliente) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      tableName,
      cliente.toMap(),
      where: 'id_clientes = ?',
      whereArgs: [cliente.idClientes],
    );
  }

  // Eliminar cliente
  Future<int> deleteCliente(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id_clientes = ?',
      whereArgs: [id],
    );
  }

  // Verificar si existe un cliente con ese DNI/RUC
  Future<bool> existeClientePorDni(String dniRuc, int idUsuario) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'dni_ruc = ? AND id_usuario = ?',
      whereArgs: [dniRuc, idUsuario],
    );
    return maps.isNotEmpty;
  }

  // Contar clientes por usuario
  Future<int> contarClientesPorUsuario(int idUsuario) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName WHERE id_usuario = ?',
      [idUsuario],
    );
    return result.first['count'] as int;
  }
}
