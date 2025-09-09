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
    'Mastercard',
    'PayPal',
    'American Express',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Método de Pago',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _metodoSeleccionado,
              onChanged: (String? newValue) {
                setState(() {
                  _metodoSeleccionado = newValue!;
                });
              },
              items: metodosPago.map((String metodo) {
                return DropdownMenuItem<String>(
                  value: metodo,
                  child: Text(metodo),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Selecione um método',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navegar para a página de recibo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReciboPage()),
                );
              },
              child: const Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}
