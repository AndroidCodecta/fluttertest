import 'package:flutter/material.dart';
import 'package:fluttertest/screens/Tienda/clientes/clientes_page.dart' as tienda;
import 'package:fluttertest/screens/Vendedor/clientes/clientes_page.dart'as vendedor;
import 'package:fluttertest/dao/usuario_dao.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UsuarioDAO _usuarioDAO = UsuarioDAO();

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complete todos los campos")),
      );
      return;
    }

    // Validar en base de datos
    final user = await _usuarioDAO.login(username, password);

    if (user != null) {
      // Login exitoso → ir a la pantalla de clientes según el rol
      if (user.rol == "1" || user.rol == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const tienda.ClientesPage()),
        );
      } else if (user.rol == "2" || user.rol == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const vendedor.ClientesPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Rol de usuario no válido")),
        );
      }
    } else {
      // Usuario o contraseña incorrectos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
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
