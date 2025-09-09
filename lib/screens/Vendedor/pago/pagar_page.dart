import 'package:flutter/material.dart';
import 'recibo_page.dart';
import 'package:fluttertest/database/database_helper.dart';

class PagarPage extends StatefulWidget {
  final List<Map<String, dynamic>> productos;
  final double total;

  const PagarPage({super.key, required this.productos, required this.total});

  @override
  State<PagarPage> createState() => _PagarPageState();
}

class _PagarPageState extends State<PagarPage> {
  String _metodoSeleccionado = 'Visa';

  final List<String> metodosPago = [
    'Visa',
    'Mastercard',
    'PayPal',
    'American Express',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Banner ampliado
          Container(
            height: 320,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Método de Pago',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Selección de método de pago
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecciona un método de pago:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  children: metodosPago.map((metodo) {
                    return ChoiceChip(
                      label: Text(metodo),
                      selected: _metodoSeleccionado == metodo,
                      onSelected: (_) {
                        setState(() {
                          _metodoSeleccionado = metodo;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Datos de pago (simulados)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Número de tarjeta: **** **** **** 1234',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Titular: Juan Pérez',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fecha de expiración: 12/26',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Monto total a pagar: \$${widget.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Crear recibo en la base de datos
                  final db = await DatabaseHelper().database;
                  final fecha = DateTime.now().toIso8601String();
                  final reciboId = await db.insert('recibo', {
                    'empresa': 'Mi Tienda',
                    'numero_recibo':
                    'R${DateTime.now().millisecondsSinceEpoch}',
                    'fecha': fecha,
                    'ruc': '12345678901',
                    'tipo_recibo': 'Boleta',
                    'subtotal': widget.total,
                    'descuento': 0,
                    'igv': 0,
                    'total': widget.total,
                    'id_clientes':
                    0, // Cambia por el id del cliente si lo tienes
                  });
                  // Insertar productos en producto_recibo
                  for (var p in widget.productos) {
                    await db.insert('producto_recibo', {
                      'nombre': p['nombre'],
                      'unid_medida': '',
                      'cantidad': p['cantidad'],
                      'descuento': 0,
                      'precio': p['precio'],
                      'id_recibo': reciboId,
                    });
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReciboPage(
                        productos: widget.productos,
                        total: widget.total,
                      ),
                    ),
                  );
                },
                child: const Text('Pagar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
