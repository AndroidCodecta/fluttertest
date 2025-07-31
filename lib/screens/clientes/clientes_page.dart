import 'package:flutter/material.dart';
import 'package:fluttertest/models/cliente.dart';
import 'agregar_cliente_page.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';
import '../login/login_page.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final List<Cliente> _clientes = [];
  final TextEditingController _busquedaController = TextEditingController();

  List<Cliente> get _clientesFiltrados {
    final query = _busquedaController.text.toLowerCase();
    if (query.isEmpty) return _clientes;
    return _clientes
        .where((c) => c.nombre.toLowerCase().contains(query) || c.dniRuc.contains(query))
        .toList();
  }

  void _abrirFormularioAgregar() async {
    final nuevoCliente = await Navigator.push<Cliente>(
      context,
      MaterialPageRoute(builder: (_) => const AgregarClientePage()),
    );

    if (nuevoCliente != null) {
      setState(() {
        _clientes.add(nuevoCliente);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Banner arriba
          SizedBox(
            width: double.infinity,
            height: 80,
            child: Image.asset(
              'assets/images/fondo.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Título y botón agregar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Clientes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _abrirFormularioAgregar,
                ),
              ],
            ),
          ),

          // Buscador
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _busquedaController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Buscar cliente...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Lista de clientes
          Expanded(
            child: ListView.builder(
              itemCount: _clientesFiltrados.length,
              itemBuilder: (_, index) {
                final cliente = _clientesFiltrados[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(cliente.nombre),
                  subtitle: Text(cliente.dniRuc),
                );
              },
            ),
          ),

          const Divider(),

          // Botón cerrar sesión
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text('Cerrar sesión'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 2),
    );
  }
}
