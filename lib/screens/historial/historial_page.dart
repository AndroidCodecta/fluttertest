// screens/historial/historial_page.dart
import 'package:flutter/material.dart';
import '../../widgets/nav_wrapper.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  // Datos de ejemplo: lista de pagos con cliente y monto
  final List<Map<String, dynamic>> historialPagos = const [
    {'cliente': 'Juan Pérez', 'monto': 120.50},
    {'cliente': 'María López', 'monto': 75.00},
    {'cliente': 'Carlos Gómez', 'monto': 250.20},
    {'cliente': 'Ana Fernández', 'monto': 180.75},
  ];

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
              'Historial de pagos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Lista de historial
          Expanded(
            child: ListView.builder(
              itemCount: historialPagos.length,
              itemBuilder: (context, index) {
                final pago = historialPagos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    title: Text(pago['cliente']),
                    subtitle: Text('Monto pagado: \$${pago['monto'].toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Aquí puedes poner la lógica para mostrar la factura
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ver factura de ${pago['cliente']}')),
                        );
                      },
                      child: const Text('Ver factura'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 3),
    );
  }
}
