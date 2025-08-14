import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _databaseName = 'toma_pedidos.db';
  static const int _databaseVersion = 1;

  // Singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onOpen: (db) async {
        // Activar llaves foráneas
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabla Usuario
    await db.execute('''
      CREATE TABLE Usuario (
        id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
        dni TEXT NOT NULL,
        nombre TEXT NOT NULL,
        usuario TEXT NOT NULL,
        password TEXT NOT NULL,
        celular TEXT
      )
    ''');

    // Tabla resumen
    await db.execute('''
      CREATE TABLE resumen (
        id_resumen INTEGER PRIMARY KEY AUTOINCREMENT,
        numero_clientes INTEGER,
        visitados INTEGER,
        exitosos INTEGER,
        no_exitosos INTEGER,
        pendiente INTEGER,
        monto_total DECIMAL(10,2),
        id_usuario INTEGER NOT NULL,
        FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
      )
    ''');

    // Tabla Clientes
    await db.execute('''
      CREATE TABLE Clientes (
        id_clientes INTEGER PRIMARY KEY AUTOINCREMENT,
        dni_ruc TEXT NOT NULL,
        nombre TEXT NOT NULL,
        direccion TEXT,
        id_usuario INTEGER NOT NULL,
        FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
      )
    ''');

    // Tabla producto_carrito
    await db.execute('''
      CREATE TABLE producto_carrito (
        id_p_carrito INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        imagen TEXT,
        unid_medida TEXT,
        cantidad INTEGER NOT NULL,
        descuento DECIMAL(10,2),
        precio DECIMAL(10,2) NOT NULL,
        id_clientes INTEGER NOT NULL,
        FOREIGN KEY (id_clientes) REFERENCES Clientes(id_clientes) ON DELETE CASCADE
      )
    ''');

    // Tabla recibo
    await db.execute('''
      CREATE TABLE recibo (
        id_recibo INTEGER PRIMARY KEY AUTOINCREMENT,
        empresa TEXT,
        numero_recibo TEXT NOT NULL,
        fecha DATE NOT NULL,
        ruc TEXT,
        tipo_recibo TEXT,
        subtotal DECIMAL(10,2),
        descuento DECIMAL(10,2),
        igv DECIMAL(10,2),
        total DECIMAL(10,2),
        id_clientes INTEGER NOT NULL,
        FOREIGN KEY (id_clientes) REFERENCES Clientes(id_clientes) ON DELETE CASCADE
      )
    ''');

    // Tabla producto_recibo
    await db.execute('''
      CREATE TABLE producto_recibo (
        id_p_recibo INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        unid_medida TEXT,
        cantidad INTEGER NOT NULL,
        descuento DECIMAL(10,2),
        precio DECIMAL(10,2) NOT NULL,
        id_recibo INTEGER NOT NULL,
        FOREIGN KEY (id_recibo) REFERENCES recibo(id_recibo) ON DELETE CASCADE
      )
    ''');
  }

  // Método para cerrar la base de datos
  Future<void> close() async {
    final db = await database;
    db.close();
  }

  // Método para eliminar la base de datos (útil para testing)
  Future<void> deleteDB() async {
    String path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);
    _database = null;
  }
}
