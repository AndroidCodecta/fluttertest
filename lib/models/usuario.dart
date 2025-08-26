class Usuario {
  final int? idUsuario;
  final String dni;
  final String nombre;
  final String usuario;
  final String password;
  final String? celular;
  final int rol;

  Usuario({
    this.idUsuario,
    required this.dni,
    required this.nombre,
    required this.usuario,
    required this.password,
    this.celular,
    required this.rol,
  });

  // Convertir de Map (de la BD) a objeto
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      dni: map['dni'],
      nombre: map['nombre'],
      usuario: map['usuario'],
      password: map['password'],
      celular: map['celular'],
      rol: map['rol'],
    );
  }

  // Convertir de objeto a Map (para insertar/actualizar)
  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'dni': dni,
      'nombre': nombre,
      'usuario': usuario,
      'password': password,
      'celular': celular,
      'rol': rol,
    };
  }
}
