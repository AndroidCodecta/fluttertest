import '../database/database_helper.dart';
import '../models/usuario.dart';

class UsuarioDao {
  static const String tableName = 'Usuario';

  // Crear usuario
  Future<int> insertUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(tableName, usuario.toMap());
  }

  // Obtener todos los usuarios
  Future<List<Usuario>> getAllUsuarios() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Usuario.fromMap(maps[i]);
    });
  }

  // Obtener usuario por ID
  Future<Usuario?> getUsuarioById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id_usuario = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

  // Obtener usuario por credenciales (login)
  Future<Usuario?> getUsuarioByCredentials(
    String usuario,
    String password,
  ) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'usuario = ? AND password = ?',
      whereArgs: [usuario, password],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

  // Actualizar usuario
  Future<int> updateUsuario(Usuario usuario) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      tableName,
      usuario.toMap(),
      where: 'id_usuario = ?',
      whereArgs: [usuario.idUsuario],
    );
  }

  // Eliminar usuario
  Future<int> deleteUsuario(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(tableName, where: 'id_usuario = ?', whereArgs: [id]);
  }

  // Verificar si existe un usuario con ese nombre de usuario
  Future<bool> existeUsuario(String usuario) async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'usuario = ?',
      whereArgs: [usuario],
    );
    return maps.isNotEmpty;
  }
}
