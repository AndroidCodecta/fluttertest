// screens/indicadores/indicadores_page.dart
import 'package:flutter/material.dart';
import '../../widgets/nav_wrapper.dart';

class IndicadoresPage extends StatelessWidget {
  const IndicadoresPage({super.key});

  // Datos de ejemplo:
  final List<Map<String, dynamic>> resumen = const [
    { 'puntos_vistas_totales': 20,
      'visitados': 12,
      'exitosos': 10,
      'no_exitosos': 2
    },
  ];

  final List<Map<String, dynamic>> indicadores = const [
    { 'visitados_porcentaje': 50,
      'realizo_pedido_porcentaje': 75,
      'no_realizo_pedido_porcentaje': 25,
      'pedido_pendiente_porcentaje': 20,
      'monto_total_ventas': 587.97
    },
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
              'Indicadores',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Lista de Inidicadores
          // Resumen
          const Text(
            'Resumen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildIndicatorRow(
                      'Puntos de visita totales:',
                      resumen[0]['puntos_vistas_totales'].toString()),
                  _buildIndicatorRow(
                      'Visitados:',
                      resumen[0]['visitados'].toString()),
                  _buildIndicatorRow(
                      'Exitosos:',
                      resumen[0]['exitosos'].toString()),
                  _buildIndicatorRow(
                      'No exitosos:',
                      resumen[0]['no_exitosos'].toString()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Indicadores
          const Text(
            'Mis indicadores',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPercentageIndicator(
                      'Visitados',
                      indicadores[0]['visitados_porcentaje']),
                  _buildPercentageIndicator(
                      'Realizó pedido',
                      indicadores[0]['realizo_pedido_porcentaje']),
                  _buildPercentageIndicator(
                      'No realizó pedido',
                      indicadores[0]['no_realizo_pedido_porcentaje']),
                  _buildPercentageIndicator(
                      'Pedido Pendiente',
                      indicadores[0]['pedido_pendiente_porcentaje']),
                  const SizedBox(height: 10),
                  _buildIndicatorRow(
                      'Monto Total Ventas:',
                      'S/.${indicadores[0]['monto_total_ventas'].toString()}',
                      isAmount: true),
                ],
              ),
            ),
          ),
        ]
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 3),
    );
  }
  Widget _buildIndicatorRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isAmount ? Colors.green : Colors.black,
              )),
        ],
      ),
    );
  }

  Widget _buildPercentageIndicator(String label, int percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$percentage% $label',
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(percentage)),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(int percentage) {
    if (percentage >= 70) return Colors.green;
    if (percentage >= 40) return Colors.orange;
    return Colors.red;
  }
}