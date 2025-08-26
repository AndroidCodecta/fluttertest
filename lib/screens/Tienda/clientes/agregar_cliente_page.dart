import 'package:flutter/material.dart';
import 'package:fluttertest/models/clientes.dart';

class AgregarClientePage extends StatefulWidget {
  const AgregarClientePage({super.key});

  @override
  State<AgregarClientePage> createState() => _AgregarClientePageState();
}

class _AgregarClientePageState extends State<AgregarClientePage> {
  final _nombreController = TextEditingController();
  final _dniRucController = TextEditingController();
  final _telefonoController = TextEditingController();
  String _codigoPais = '+51'; // Default: Perú

  @override
  void dispose() {
    _nombreController.dispose();
    _dniRucController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Agregar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Foto de perfil opcional (placeholder)
            Center(
              child: GestureDetector(
                onTap: () {
                  // Aquí puedes abrir el selector de imágenes más adelante
                },
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.camera_alt, size: 30, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nombre
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // DNI o RUC
            TextField(
              controller: _dniRucController,
              decoration: const InputDecoration(
                labelText: 'DNI o RUC',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Teléfono con selector de país
            Row(
              children: [
                DropdownButton<String>(
                  value: _codigoPais,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _codigoPais = value;
                      });
                    }
                  },
                  items: const [
                    DropdownMenuItem(value: '+51', child: Text('🇵🇪 +51')),
                    DropdownMenuItem(value: '+54', child: Text('🇦🇷 +54')),
                    DropdownMenuItem(value: '+57', child: Text('🇨🇴 +57')),
                    DropdownMenuItem(value: '+1', child: Text('🇺🇸 +1')),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _telefonoController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Botón Agregar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final cliente = Clientes(
                    nombre: _nombreController.text,
                    dniRuc: _dniRucController.text,
                    telefono: '$_codigoPais ${_telefonoController.text}',
                    idUsuario: 0,
                  );
                  Navigator.pop(context, cliente);
                },
                child: const Text('Agregar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
