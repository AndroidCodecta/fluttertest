class Usuario {
  int? idUsuario;
  String dni;
  String nombre;
  String usuario;
  String contrasena;
  String? celular;

  Usuario({
    this.idUsuario,
    required this.dni,
    required this.nombre,
    required this.usuario,
    required this.contrasena,
    this.celular,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      dni: map['dni'],
      nombre: map['nombre'],
      usuario: map['usuario'],
      contrasena: map['contraseña'],
      celular: map['celular'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'dni': dni,
      'nombre': nombre,
      'usuario': usuario,
      'contraseña': contrasena,
      'celular': celular,
    };
  }
}
