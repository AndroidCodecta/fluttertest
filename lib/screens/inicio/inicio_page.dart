// screens/inicio/inicio_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertest/widgets/nav_wrapper.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  final List<Map<String, String>> categorias = const [
    {'nombre': 'Limpieza', 'icono': '🧼'},
    {'nombre': 'Abarrotes', 'icono': '🥫'},
    {'nombre': 'Bebidas', 'icono': '🥤'},
    {'nombre': 'Snacks', 'icono': '🍪'},
    {'nombre': 'Carnes', 'icono': '🍖'},
    {'nombre': 'Lácteos', 'icono': '🥛'},
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
              'Categorías',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Cuadrícula de categorías
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: categorias.map((categoria) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Acción al tocar una categoría
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              categoria['icono'] ?? '',
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categoria['nombre'] ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavWrapper(currentIndex: 0),
    );
  }
}