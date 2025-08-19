// screens/carrito/carrito_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';
import 'package:fluttertest/screens/tienda/pago/pagar_page.dart';


class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  // Simulación de productos en carrito
  List<Map<String, dynamic>> carrito = [
    {
      'nombre': 'Producto A',
      'precio': 50.0,
      'cantidad': 2,
    },
    {
      'nombre': 'Producto B',
      'precio': 30.0,
      'cantidad': 1,
    },
    {
      'nombre': 'Producto C',
      'precio': 70.0,
      'cantidad': 3,
    },
  ];

  double get subtotal => carrito.fold(
      0, (total, item) => total + (item['precio'] * item['cantidad']));

  double get descuento => subtotal * 0.1; // 10% de descuento como ejemplo

  double get igv => (subtotal - descuento) * 0.18; // IGV 18%

  double get total => subtotal - descuento + igv;

  void _incrementCantidad(int index) {
    setState(() {
      carrito[index]['cantidad']++;
    });
  }

  void _decrementCantidad(int index) {
    if (carrito[index]['cantidad'] > 1) {
      setState(() {
        carrito[index]['cantidad']--;
      });
    }
  }

  void _eliminarProducto(int index) {
    setState(() {
      carrito.removeAt(index);
    });
  }

  void _realizarCompra() {
    // Lógica para procesar compra aquí
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compra realizada con éxito')),
    );
    setState(() {
      carrito.clear();
    });
  }

  void _cerrarCompra() {
    // Lógica para cerrar o limpiar carrito sin comprar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compra cancelada')),
    );
    setState(() {
      carrito.clear();
    });
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
              'Carrito de Compras',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Lista de productos en carrito
          Expanded(
            child: carrito.isEmpty
                ? const Center(child: Text('El carrito está vacío'))
                : ListView.builder(
                    itemCount: carrito.length,
                    itemBuilder: (context, index) {
                      final producto = carrito[index];
                      final precioTotal =
                          producto['precio'] * producto['cantidad'];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto['nombre'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Precio unitario: \$${producto['precio'].toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () => _decrementCantidad(index),
                                  ),
                                  Text(
                                    producto['cantidad'].toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () => _incrementCantidad(index),
                                  ),
                                  const Spacer(), // Empuja el botón borrar a la derecha
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () => _eliminarProducto(index),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Total: \$${precioTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Resumen y botones
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                )
              ],
            ),
            child: Column(
              children: [
                _buildResumenRow('Subtotal:', subtotal),
                _buildResumenRow('Descuento:', descuento),
                _buildResumenRow('IGV (18%):', igv),
                const Divider(),
                _buildResumenRow('Total:', total, isBold: true),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PagarPage()),
                          );
                        },
                        child: const Text('Realizar compra'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: carrito.isEmpty ? null : _cerrarCompra,
                        child: const Text('Cerrar compra'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 1),
    );
  }

  Widget _buildResumenRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
