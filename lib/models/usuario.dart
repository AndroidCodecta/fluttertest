class Usuario {
  int? idUsuario;
  String dni;
  String nombre;
  String usuario;
  String password;
  String? celular;

  Usuario({
    this.idUsuario,
    required this.dni,
    required this.nombre,
    required this.usuario,
    required this.password,
    this.celular,
  });

  // Convertir desde Map (SQLite)
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      dni: map['dni'],
      nombre: map['nombre'],
      usuario: map['usuario'],
      password: map['password'],
      celular: map['celular'],
    );
  }

  // Convertir a Map (SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'dni': dni,
      'nombre': nombre,
      'usuario': usuario,
      'password': password,
      'celular': celular,
    };
  }

  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, dni: $dni, nombre: $nombre, usuario: $usuario}';
  }
}
