import 'package:flutter/material.dart';
import 'package:fluttertest/screens/Tienda/historial/historial_page_2.dart'
    as tienda;
import 'package:fluttertest/screens/Tienda/inicio/inicio_page.dart' as tienda;
import 'package:fluttertest/screens/Tienda/carrito/carrito_page.dart' as tienda;
import 'package:fluttertest/screens/Tienda/clientes/clientes_page.dart' as tienda;

import 'package:fluttertest/screens/Vendedor/historial/historial_page_2.dart' as vendedor;
import 'package:fluttertest/screens/Vendedor/inicio/inicio_page.dart' as vendedor;
import 'package:fluttertest/screens/Vendedor/carrito/carrito_page.dart' as vendedor;
import 'package:fluttertest/screens/Vendedor/clientes/clientes_page.dart' as vendedor;

class NavWrapper extends StatelessWidget {
  final int currentIndex;
  final int rol; 

  const NavWrapper({super.key, required this.currentIndex, required this.rol});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget? page;
    if (rol == 1) {
      // Tienda
      switch (index) {
        case 0:
          page = const tienda.InicioPage();
          break;
        case 1:
          page = const tienda.CarritoPage();
          break;
        case 2:
          page = const tienda.ClientesPage();
          break;
        case 3:
          page = const tienda.HistorialPage2();
          break;
        default:
          page = null;
      }
    } else if (rol == 2) {
      // Vendedor
      switch (index) {
        case 0:
          page = const vendedor.InicioPage();
          break;
        case 1:
          page = const vendedor.CarritoPage();
          break;
        case 2:
          page = const vendedor.ClientesPage();
          break;
        case 3:
          page = const vendedor.HistorialPage2();
          break;
        default:
          page = null;
      }
    }

    if (page != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => page!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Carrito',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clientes'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
      ],
    );
  }
}
