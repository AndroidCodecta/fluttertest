import 'package:flutter/material.dart';
import 'package:fluttertest/screens/tienda/productos/producto_detalle_page.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';
import 'package:fluttertest/database/database_helper.dart';

class ProductosPage extends StatefulWidget {
  final String categoria;

  const ProductosPage({super.key, required this.categoria});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _productos = [];
  List<Map<String, dynamic>> _productosFiltrados = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductos();
    _searchController.addListener(_filtrarProductos);
  }

  Future<void> _loadProductos() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    final db = await DatabaseHelper().database;
    final productos = await db.query(
      'Producto',
      where: 'categoria = ?',
      whereArgs: [widget.categoria],
    );
    if (mounted) {
      setState(() {
        _productos = productos;
        _productosFiltrados = productos;
        _isLoading = false;
      });
    }
  }

  void _filtrarProductos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _productosFiltrados = _productos
          .where((p) => (p['nombre'] as String).toLowerCase().contains(query))
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Productos - ${widget.categoria}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar producto...',
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _productosFiltrados.isEmpty
                  ? const Center(
                      child: Text('No hay productos en esta categoría'),
                    )
                  : GridView.builder(
                      itemCount: _productosFiltrados.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3 / 4,
                          ),
                      itemBuilder: (context, index) {
                        final producto = _productosFiltrados[index];
                        return GestureDetector(
                          onTap: () {
                            final pd = {
                              'nombre': producto['nombre'],
                              'descripcion': producto['descripcion'],
                              'precio': (producto['precio'] as num).toDouble(),
                              'stock': producto['stock'] ?? 1,
                            };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductoDetallePage(producto: pd),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.shopping_bag, size: 48),
                                  const SizedBox(height: 8),
                                  Text(
                                    producto['nombre'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    producto['descripcion'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\$${(producto['precio'] as num).toDouble().toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 0, rol: 1),
    );
  }
}
