import 'package:flutter/material.dart';
import 'screens/login/login_page.dart';
import 'database/database_helper.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DatabaseHelper().database;

  // Insertar usuario de prueba si no existe
  await db.insert(
    'Usuario',
    {
      'dni': '12345678',
      'nombre': 'Usuario Prueba',
      'usuario': 'admin',
      'contraseña': '1234', 
      'celular': '987654321'
    },
    conflictAlgorithm: ConflictAlgorithm.ignore, 
  );

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
