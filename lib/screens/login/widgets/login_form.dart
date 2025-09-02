import 'package:flutter/material.dart';
import 'package:fluttertest/screens/Tienda/clientes/clientes_page.dart' as tienda;
import 'package:fluttertest/screens/Vendedor/clientes/clientes_page.dart' as vendedor;

import 'package:fluttertest/dao/usuario_dao.dart'; // Asegúrate de que esta ruta sea la correcta

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

iscord

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