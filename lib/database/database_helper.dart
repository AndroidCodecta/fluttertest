import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'tomapedidos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Activar llaves foráneas
        await db.execute('PRAGMA foreign_keys = ON');

        // Crear tablas
        await db.execute('''
          CREATE TABLE Usuario (
              id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
              dni TEXT NOT NULL,
              nombre TEXT NOT NULL,
              usuario TEXT NOT NULL,
              contraseña TEXT NOT NULL,
              celular TEXT
          );
        ''');

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
          );
        ''');

        await db.execute('''
          CREATE TABLE Clientes (
              id_clientes INTEGER PRIMARY KEY AUTOINCREMENT,
              dni_ruc TEXT NOT NULL,
              nombre TEXT NOT NULL,
              direccion TEXT,
              celular TEXT,
              id_usuario INTEGER NOT NULL,
              FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
          );
        ''');

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
          );
        ''');

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
          );
        ''');

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
          );
        ''');
      },
    );
  }

  // Cerrar conexión
  Future closeDB() async {
    final db = await database;
    db.close();
  }
}