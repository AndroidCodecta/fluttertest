import 'package:flutter/material.dart';
import 'package:fluttertest/screens/tienda/productos/productos_page.dart'
    as tienda;
import 'package:fluttertest/widgets/nav_wrapper.dart';
import 'package:fluttertest/database/database_helper.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _categorias = [];
  List<String> _categoriasFiltradas = [];

  @override
  void initState() {
    super.initState();
    _loadCategorias();
    _searchController.addListener(_filtrarCategorias);
  }

  Future<void> _loadCategorias() async {
    final db = await DatabaseHelper().database;
    final productos = await db.query('Producto');
    final categoriasSet = <String>{};
    for (var p in productos) {
      if (p['categoria'] != null && p['categoria'].toString().isNotEmpty) {
        categoriasSet.add(p['categoria'].toString());
      }
    }
    setState(() {
      _categorias = categoriasSet.toList();
      _categoriasFiltradas = _categorias;
    });
  }

  void _filtrarCategorias() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _categoriasFiltradas = _categorias
          .where((cat) => cat.toLowerCase().contains(query))
          .toList();
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
          SizedBox(
            width: double.infinity,
            height: 80,
            child: Image.asset('assets/images/fondo.jpg', fit: BoxFit.cover),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Categorías',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar categoría...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                tienda.ProductosPage(categoria: categoria),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              categoria,
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
      bottomNavigationBar: const NavWrapper(currentIndex: 0, rol: 1),
    );
  }
}
