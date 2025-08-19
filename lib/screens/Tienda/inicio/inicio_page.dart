import 'package:flutter/material.dart';
import 'package:fluttertest/screens/productos/productos_page.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _todasLasCategorias = const [
    {'nombre': 'Limpieza', 'icono': '🧼'},
    {'nombre': 'Abarrotes', 'icono': '🥫'},
    {'nombre': 'Bebidas', 'icono': '🥤'},
    {'nombre': 'Snacks', 'icono': '🍪'},
    {'nombre': 'Carnes', 'icono': '🍖'},
    {'nombre': 'Lácteos', 'icono': '🥛'},
  ];

  List<Map<String, String>> _categoriasFiltradas = [];

  @override
  void initState() {
    super.initState();
    _categoriasFiltradas = _todasLasCategorias;
    _searchController.addListener(_filtrarCategorias);
  }

  void _filtrarCategorias() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _categoriasFiltradas = _todasLasCategorias.where((categoria) {
        return categoria['nombre']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Categorías',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar categoría...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Cuadrícula de categorías
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: _categoriasFiltradas.map((categoria) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductosPage(categoria: categoria['nombre']!),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              categoria['icono'] ?? '',
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categoria['nombre'] ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 0),
    );
  }
}
