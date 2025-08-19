class Clientes {
  int? idClientes;
  String dniRuc;
  String nombre;
  String telefono;
  String? direccion;
  int idUsuario;

  Clientes({
    this.idClientes,
    required this.dniRuc,
    required this.nombre,
    this.direccion,
    required this.telefono,
    required this.idUsuario,
  });

  factory Clientes.fromMap(Map<String, dynamic> map) {
    return Clientes(
      idClientes: map['id_clientes'],
      dniRuc: map['dni_ruc'],
      nombre: map['nombre'],
      telefono: map['telefono'],
      direccion: map['direccion'],
      idUsuario: map['id_usuario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_clientes': idClientes,
      'dni_ruc': dniRuc,
      'nombre': nombre,
      'direccion': direccion,
      'id_usuario': idUsuario,
      'telefono': telefono,
    };
  }
}

