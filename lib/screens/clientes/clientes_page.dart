import 'package:flutter/material.dart';
import 'package:fluttertest/models/cliente.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';
import '../indicadores/indicadores_page.dart';
import '../login/login_page.dart';
import '../inicio/inicio_page.dart';
import 'agregar_cliente_page.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final List<Cliente> _clientes = [
    Cliente(nombre: 'Tienda San Juan', dniRuc: '10458963215', telefono: '987654321'),
  ];

  final TextEditingController _busquedaController = TextEditingController();

  List<Cliente> get _clientesFiltrados {
    final query = _busquedaController.text.toLowerCase();
    if (query.isEmpty) return _clientes;
    return _clientes
        .where((c) =>
            c.nombre.toLowerCase().contains(query) ||
            c.dniRuc.contains(query))
        .toList();
  }

  void _abrirAgregarCliente() async {
    final nuevoCliente = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AgregarClientePage()),
    );
    if (nuevoCliente != null) {
      setState(() {
        _clientes.add(nuevoCliente);
      });
    }
  }

  void _abrirIndicadores() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const IndicadoresPage()),
    );
  }

  void _mostrarDialogoSistemaPedido(Cliente cliente) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sistema de pedido'),
        content: Text('¿Qué deseas hacer con "${cliente.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InicioPage()),
              );
            },
            child: const Text('Realizar pedido'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              _mostrarMotivoDialog(cliente);
            },
            child: const Text('No realizar pedido'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _mostrarMotivoDialog(Cliente cliente) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Motivo'),
        content: const Text('¿Por qué no se realizará el pedido?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Motivo: Cerrado')),
              );
            },
            child: const Text('Cerrado'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Motivo: Clausurado')),
              );
            },
            child: const Text('Clausurado'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Motivo: No está el responsable')),
              );
            },
            child: const Text('No está el responsable'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: _abrirAgregarCliente,
                      child: const Text('+ Agregar'),
                    ),
                  ),
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
                  onTap: () => _mostrarDialogoSistemaPedido(cliente),
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
