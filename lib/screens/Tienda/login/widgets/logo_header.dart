import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Bienvenido',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/logo.jpg'), // Asegúrate de tener este archivo
        ),
      ],
    );
  }
}
