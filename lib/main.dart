import 'package:flutter/material.dart';
import 'screens/login/login_page.dart';
import 'database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DatabaseHelper().database;

  // Crear tabla Producto si no existe
  await db.execute('''
    CREATE TABLE IF NOT EXISTS Producto (
      id_producto INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT,
      descripcion TEXT,
      precio REAL,
      stock INTEGER,
      categoria TEXT
    )
  ''');

  // Insertar usuario de ejemplo
  await db.insert('Usuario', {
    'id_usuario': 1,
    'dni': '12345678',
    'nombre': 'Usuario Prueba',
    'usuario': 'admin',
    'password': '1234',
    'celular': '987654321',
    'rol': 1,
  }, conflictAlgorithm: ConflictAlgorithm.ignore);
  await db.insert('Usuario', {
    'id_usuario': 2,
    'dni': '12345679',
    'nombre': 'Usuario Prueba Vendedor',
    'usuario': 'vendedor',
    'password': '12345',
    'celular': '987645678',
    'rol': 2,
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  // Insertar productos de ejemplo
  await db.insert('Producto', {
    'nombre': 'Detergente',
    'descripcion': 'Para ropa blanca y de color',
    'precio': 25.5,
    'stock': 15,
    'categoria': 'Limpieza',
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('Producto', {
    'nombre': 'Jabón',
    'descripcion': 'Antibacterial',
    'precio': 10.0,
    'stock': 30,
    'categoria': 'Limpieza',
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('Producto', {
    'nombre': 'Desinfectante',
    'descripcion': 'Multiusos',
    'precio': 15.0,
    'stock': 10,
    'categoria': 'Limpieza',
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('Producto', {
    'nombre': 'Arroz',
    'descripcion': 'Grano largo',
    'precio': 12.0,
    'stock': 50,
    'categoria': 'Abarrotes',
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('Producto', {
    'nombre': 'Frijoles',
    'descripcion': 'Negros o rojos',
    'precio': 14.5,
    'stock': 40,
    'categoria': 'Abarrotes',
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  await db.insert('Producto', {
    'nombre': 'Aceite',
    'descripcion': 'Vegetal 1L',
    'precio': 22.0,
    'stock': 20,
    'categoria': 'Abarrotes',
  }, conflictAlgorithm: ConflictAlgorithm.ignore);

  // ...inserts de producto_recibo existentes...
  await db.insert('producto_recibo', {
    'nombre': 'Laptop HP',
    'unid_medida': 'unidad',
    'cantidad': 2,
    'descuento': 100.0,
    'precio': 2500.00,
    'id_recibo': 1,
  });

  await db.insert('producto_recibo', {
    'nombre': 'Mouse Logitech',
    'unid_medida': 'unidad',
    'cantidad': 3,
    'descuento': 10.0,
    'precio': 80.00,
    'id_recibo': 1,
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
