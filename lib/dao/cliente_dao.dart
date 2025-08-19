import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/clientes.dart';

class ClientesDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertarCliente(Clientes cliente) async {
    final db = await _dbHelper.database;
    return await db.insert(
      'Clientes',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Clientes>> obtenerClientes() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Clientes');

    return List.generate(maps.length, (i) {
      return Clientes.fromMap(maps[i]);
    });
  }

  Future<Clientes?> obtenerClientePorId(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Clientes',
      where: 'id_clientes = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Clientes.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> actualizarCliente(Clientes cliente) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Clientes',
      cliente.toMap(),
      where: 'id_clientes = ?',
      whereArgs: [cliente.idClientes],
    );
  }

  Future<int> eliminarCliente(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Clientes',
      where: 'id_clientes = ?',
      whereArgs: [id],
    );
  }
}
