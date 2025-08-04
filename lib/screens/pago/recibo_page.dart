import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';

class ReciboPage extends StatelessWidget {
  const ReciboPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productosComprados = [
      {'nombre': 'Detergente', 'cantidad': 2, 'precio': 25.5},
      {'nombre': 'Arroz', 'cantidad': 1, 'precio': 12.0},
    ];

    final double subtotal = productosComprados.fold(
      0.0,
      (total, item) => total + (item['cantidad'] * item['precio']),
    );

    final double total = subtotal; // Podrías agregar IGV si deseas

    return Scaffold(
      body: Column(
        children: [
          // Banner con estilo estándar
          SizedBox(
            width: double.infinity,
            height: 80,
            child: Image.asset(
              'assets/images/fondo.jpg',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            'Recibo de Compra',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Detalle de compra:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  Expanded(
                    child: ListView.builder(
                      itemCount: productosComprados.length,
                      itemBuilder: (context, index) {
                        final producto = productosComprados[index];
                        final double totalProducto = producto['cantidad'] * producto['precio'];

                        return ListTile(
                          title: Text(producto['nombre']),
                          subtitle: Text('${producto['cantidad']} x \$${producto['precio'].toStringAsFixed(2)}'),
                          trailing: Text('\$${totalProducto.toStringAsFixed(2)}'),
                        );
                      },
                    ),
                  ),

                  const Divider(thickness: 1.5),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                        Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Descargando recibo...')),
                            );
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Descargar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Compartiendo recibo...')),
                            );
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Compartir'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 0),
    );
  }
}
