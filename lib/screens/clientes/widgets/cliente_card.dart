import 'package:flutter/material.dart';

class ClienteCard extends StatelessWidget {
  final String nombre;
  final String documento;

  const ClienteCard({
    super.key,
    required this.nombre,
    required this.documento,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.png'), // Usa una imagen local o red
        ),
        title: Text(nombre),
        subtitle: Text(documento),
      ),
    );
  }
}
