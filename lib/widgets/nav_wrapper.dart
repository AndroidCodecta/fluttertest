// widgets/nav_wrapper.dart
import 'package:flutter/material.dart';
import '../screens/inicio/inicio_page.dart';
// import '../screens/carrito/carrito_page.dart';
import '../screens/clientes/clientes_page.dart';
// import '../screens/historial/historial_page.dart';


class NavWrapper extends StatelessWidget {
  final int currentIndex;

  const NavWrapper({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = const InicioPage();
        break;
      case 2:
        page = const ClientesPage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Colors.black,       // <-- Color seleccionado
      unselectedItemColor: Colors.black54,   // <-- Color no seleccionado
      backgroundColor: Colors.white,         // <-- Fondo blanco
      type: BottomNavigationBarType.fixed,   // <-- Para que no se mueva el ícono
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Carrito'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clientes'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
      ],
    );
  }
}
