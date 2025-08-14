class Cliente {
  int? idClientes;
  String dniRuc;
  String nombre;
  String? direccion;
  int idUsuario;

  Cliente({
    this.idClientes,
    required this.dniRuc,
    required this.nombre,
    this.direccion,
    required this.idUsuario,
  });

  // Convertir desde Map (SQLite)
  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      idClientes: map['id_clientes'],
      dniRuc: map['dni_ruc'],
      nombre: map['nombre'],
      direccion: map['direccion'],
      idUsuario: map['id_usuario'],
    );
  }

  // Convertir a Map (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id_clientes': idClientes,
      'dni_ruc': dniRuc,
      'nombre': nombre,
      'direccion': direccion,
      'id_usuario': idUsuario,
    };
  }

  @override
  String toString() {
    return 'Cliente{idClientes: $idClientes, dniRuc: $dniRuc, nombre: $nombre, idUsuario: $idUsuario}';
  }
}
