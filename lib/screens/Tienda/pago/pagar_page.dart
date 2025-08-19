import 'package:flutter/material.dart';
import 'recibo_page.dart';

class PagarPage extends StatefulWidget {
  const PagarPage({super.key});

  @override
  State<PagarPage> createState() => _PagarPageState();
}

class _PagarPageState extends State<PagarPage> {
  String _metodoSeleccionado = 'Visa';

  final List<String> metodosPago = [
    'Visa',
    'MasterCard',
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
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),

          const SizedBox(height: 16),

          // Selección de método de pago
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selecciona un método de pago:', style: TextStyle(fontSize: 18)),
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
              children: const [
                Text('Número de tarjeta: **** **** **** 1234', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Titular: Juan Pérez', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Fecha de expiración: 12/26', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text('Monto total a pagar: \$145.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ReciboPage()),
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
