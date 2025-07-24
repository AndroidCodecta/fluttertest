// screens/inicio/inicio_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> categorias = [
    'Farmacia', 'Librería', 'Tecnología', 'Moda', 'Hogar', 'Bebidas y Licores', 'Limpieza'
  ];

  final List<Map<String, String>> productos = [
    {'nombre': 'Paracetamol', 'codigo': 'F001', 'categoria': 'Farmacia'},
    {'nombre': 'Cuaderno A4', 'codigo': 'L002', 'categoria': 'Librería'},
    {'nombre': 'Mouse inalámbrico', 'codigo': 'T003', 'categoria': 'Tecnología'},
    {'nombre': 'Polo negro', 'codigo': 'M004', 'categoria': 'Moda'},
    {'nombre': 'Silla ergonómica', 'codigo': 'H005', 'categoria': 'Hogar'},
    {'nombre': 'Vino tinto', 'codigo': 'B006', 'categoria': 'Bebidas y Licores'},
    {'nombre': 'Detergente', 'codigo': 'C007', 'categoria': 'Limpieza'},
  ];

  String _filtroCategoria = 'Todas';

  List<Map<String, String>> get _productosFiltrados {
    final query = _searchController.text.toLowerCase();

    return productos.where((p) {
      final coincideCategoria = _filtroCategoria == 'Todas' || p['categoria'] == _filtroCategoria;
      final coincideTexto = p['nombre']!.toLowerCase().contains(query) || p['codigo']!.toLowerCase().contains(query);
      return coincideCategoria && coincideTexto;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre o código...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildChip('Todas'),
                ...categorias.map((c) => _buildChip(c)).toList(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _productosFiltrados.length,
              itemBuilder: (context, index) {
                final p = _productosFiltrados[index];
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(p['nombre']!),
                  subtitle: Text('${p['codigo']} - ${p['categoria']}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 0),
    );
  }

  Widget _buildChip(String nombre) {
    final selected = _filtroCategoria == nombre;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(nombre),
        selected: selected,
        onSelected: (_) {
          setState(() {
            _filtroCategoria = nombre;
          });
        },
      ),
    );
  }
}
