// screens/carrito/carrito_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';
import 'package:fluttertest/screens/tienda/pago/pagar_page.dart';
import 'package:fluttertest/database/database_helper.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  List<Map<String, dynamic>> carrito = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCarrito();
  }

  Future<void> _loadCarrito() async {
    setState(() {
      _isLoading = true;
    });
    final db = await DatabaseHelper().database;
    final productos = await db.query('producto_carrito');
    setState(() {
      carrito = productos;
      _isLoading = false;
    });
  }

  double get subtotal => carrito.fold(
    0,
    (total, item) => total + (item['precio'] * item['cantidad']),
  );

  double get descuento => subtotal * 0.1; // 10% de descuento como ejemplo

  double get igv => (subtotal - descuento) * 0.18; // IGV 18%

  double get total => subtotal - descuento + igv;

  void _incrementCantidad(int index) {
    final producto = carrito[index];
    final id = producto['id_p_carrito'];
    final nuevaCantidad = (producto['cantidad'] as int) + 1;
    DatabaseHelper().database.then((db) async {
      await db.update(
        'producto_carrito',
        {'cantidad': nuevaCantidad},
        where: 'id_p_carrito = ?',
        whereArgs: [id],
      );
      await _loadCarrito();
    });
  }

  void _decrementCantidad(int index) {
    final producto = carrito[index];
    final id = producto['id_p_carrito'];
    final cantidadActual = producto['cantidad'] as int;
    if (cantidadActual > 1) {
      final nuevaCantidad = cantidadActual - 1;
      DatabaseHelper().database.then((db) async {
        await db.update(
          'producto_carrito',
          {'cantidad': nuevaCantidad},
          where: 'id_p_carrito = ?',
          whereArgs: [id],
        );
        await _loadCarrito();
      });
    }
  }

  void _eliminarProducto(int index) {
    final producto = carrito[index];
    final id = producto['id_p_carrito'];
    DatabaseHelper().database.then((db) async {
      await db.delete(
        'producto_carrito',
        where: 'id_p_carrito = ?',
        whereArgs: [id],
      );
      await _loadCarrito();
    });
  }

  void _realizarCompra() {
    // Lógica para procesar compra aquí
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Compra realizada con éxito')));
    setState(() {
      carrito.clear();
    });
  }

  void _cerrarCompra() {
    // Lógica para cerrar o limpiar carrito sin comprar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Compra cancelada')));
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
            child: Image.asset('assets/images/fondo.jpg', fit: BoxFit.cover),
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
                ? const Center(child: Text('No tienes productos en el carrito'))
                : ListView.builder(
                    itemCount: carrito.length,
                    itemBuilder: (context, index) {
                      final producto = carrito[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto['nombre'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
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
                                  'Total: \$${(producto['precio'] * producto['cantidad']).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                ),
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
                            MaterialPageRoute(
                              builder: (_) =>
                                  PagarPage(productos: carrito, total: total),
                            ),
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
      bottomNavigationBar: const NavWrapper(currentIndex: 1, rol: 1),
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
