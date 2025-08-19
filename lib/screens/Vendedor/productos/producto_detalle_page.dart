import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';

class ProductoDetallePage extends StatefulWidget {
  final Map<String, dynamic> producto;

  const ProductoDetallePage({
    super.key,
    required this.producto,
  });

  @override
  State<ProductoDetallePage> createState() => _ProductoDetallePageState();
}

class _ProductoDetallePageState extends State<ProductoDetallePage> {
  int _cantidad = 1;

  final List<String> _imagenes = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ_2AoSKQemmQXda_XSODr9KzPbILviZeT_Q&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDGBwWpVeulCD8FDmsgQSVkXkQ_yhRcoqhVQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0I--vLxuv9ICjDe5Pjn35U3fyXDzIgDV3tw&s',
  ];

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;
    final String nombre = (producto['nombre'] ?? 'Producto desconocido').toString();
    final String descripcion = (producto['descripcion'] ?? '').toString();
    final double precioUnitario = (producto['precio'] ?? 0).toDouble();
    final int stock = (producto['stock'] ?? 1).toInt();
    final double precioFinal = precioUnitario * _cantidad;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 80,
              child: Image.asset(
                'assets/images/fondo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: _imagenes.length,
                itemBuilder: (context, index) {
                  return FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.jpg',
                    image: _imagenes[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Precio unitario: \$${precioUnitario.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    descripcion,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stock disponible: $stock unidades',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text('Cantidad:', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _cantidad > 1 ? () => setState(() => _cantidad--) : null,
                  ),
                  Text('$_cantidad', style: const TextStyle(fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _cantidad < stock ? () => setState(() => _cantidad++) : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Text('Total: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    '\$${precioFinal.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Agregado $_cantidad x "$nombre" al carrito'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 0),
    );
  }
}
