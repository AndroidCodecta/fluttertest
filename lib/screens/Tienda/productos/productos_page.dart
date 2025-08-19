import 'package:flutter/material.dart';
import 'package:fluttertest/screens/tienda/productos/producto_detalle_page.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';

class ProductosPage extends StatefulWidget {
  final String categoria;

  const ProductosPage({super.key, required this.categoria});

  @override
  State<ProductosPage> createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<Map<String, dynamic>>> productosPorCategoria = {
    'Limpieza': [
      {
        'nombre': 'Detergente',
        'descripcion': 'Para ropa blanca y de color',
        'precio': 25.5,
        'stock': 15,
      },
      {
        'nombre': 'Jabón',
        'descripcion': 'Antibacterial',
        'precio': 10.0,
        'stock': 30,
      },
      {
        'nombre': 'Desinfectante',
        'descripcion': 'Multiusos',
        'precio': 15.0,
        'stock': 10,
      },
    ],
    'Abarrotes': [
      {
        'nombre': 'Arroz',
        'descripcion': 'Grano largo',
        'precio': 12.0,
        'stock': 50,
      },
      {
        'nombre': 'Frijoles',
        'descripcion': 'Negros o rojos',
        'precio': 14.5,
        'stock': 40,
      },
      {
        'nombre': 'Aceite',
        'descripcion': 'Vegetal 1L',
        'precio': 22.0,
        'stock': 20,
      },
    ],
  };

  List<Map<String, dynamic>> _productosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _productosFiltrados = productosPorCategoria[widget.categoria] ?? [];
    _searchController.addListener(_filtrarProductos);
  }

  void _filtrarProductos() {
    final query = _searchController.text.toLowerCase();
    final productos = productosPorCategoria[widget.categoria] ?? [];

    setState(() {
      _productosFiltrados = productos
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
            child: Image.asset(
              'assets/images/fondo.jpg',
              fit: BoxFit.cover,
            ),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: _productosFiltrados.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          builder: (_) => ProductoDetallePage(producto: pd),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.shopping_bag, size: 48),
                            const SizedBox(height: 8),
                            Text(
                              producto['nombre'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
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
                                  color: Colors.green, fontWeight: FontWeight.bold),
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
      bottomNavigationBar: const NavWrapper(currentIndex: 0),
    );
  }
}
