import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/usuario.dart';

class UsuarioDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Insertar usuario
  Future<int> insertUsuario(Usuario usuario) async {
    final db = await _dbHelper.database;
    return await db.insert('Usuario', usuario.toMap());
  }

  // Obtener usuario por ID
  Future<Usuario?> getUsuarioById(int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Usuario',
      where: 'id_usuario = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    }
    return null;
  }

  // Obtener todos los usuarios
  Future<List<Usuario>> getAllUsuarios() async {
    final db = await _dbHelper.database;
    final result = await db.query('Usuario');
    return result.map((map) => Usuario.fromMap(map)).toList();
  }

  // Actualizar usuario
  Future<int> updateUsuario(Usuario usuario) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Usuario',
      usuario.toMap(),
      where: 'id_usuario = ?',
      whereArgs: [usuario.idUsuario],
    );
  }

  // Eliminar usuario
  Future<int> deleteUsuario(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'Usuario',
      where: 'id_usuario = ?',
      whereArgs: [id],
    );
  }

  // Buscar usuario por credenciales (ejemplo para login)
  Future<Usuario?> login(String user, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'Usuario',
      where: 'usuario = ? AND password = ?',
      whereArgs: [user, password],
    );
    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    }
    return null;
  }
}
