import 'package:flutter/material.dart';
import 'package:fluttertest/models/cliente.dart';
import 'agregar_cliente_page.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final List<Cliente> _clientes = [];
  final TextEditingController _busquedaController = TextEditingController();
  int _selectedIndex = 2; // Clientes es el tercero (índice 2)

  List<Cliente> get _clientesFiltrados {
    final query = _busquedaController.text.toLowerCase();
    if (query.isEmpty) return _clientes;
    return _clientes.where((c) =>
        c.nombre.toLowerCase().contains(query) || c.dniRuc.contains(query)).toList();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _abrirFormularioAgregar,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // O cerrar sesión real
                },
                child: const Text('Cerrar sesión'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Importante para mostrar todos los textos
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }
}
