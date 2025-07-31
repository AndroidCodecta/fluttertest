import 'package:flutter/material.dart';
import 'package:fluttertest/screens/clientes/clientes_page.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Aquí va la lógica de validación/autenticación
    // print('Usuario: $username');
    // print('Contraseña: $password');

    // Ir a la pantalla de inicio
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ClientesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Usuario',
            
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _login,
            child: const Text('Iniciar sesión'),
          ),
        ),
      ],
    );
  }
}
