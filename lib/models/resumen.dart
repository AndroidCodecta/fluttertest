class Resumen {
  int? idResumen;
  int? numeroClientes;
  int? visitados;
  int? exitosos;
  int? noExitosos;
  int? pendiente;
  double? montoTotal;
  int idUsuario;

  Resumen({
    this.idResumen,
    this.numeroClientes,
    this.visitados,
    this.exitosos,
    this.noExitosos,
    this.pendiente,
    this.montoTotal,
    required this.idUsuario,
  });

  factory Resumen.fromMap(Map<String, dynamic> map) {
    return Resumen(
      idResumen: map['id_resumen'],
      numeroClientes: map['numero_clientes'],
      visitados: map['visitados'],
      exitosos: map['exitosos'],
      noExitosos: map['no_exitosos'],
      pendiente: map['pendiente'],
      montoTotal: map['monto_total']?.toDouble(),
      idUsuario: map['id_usuario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_resumen': idResumen,
      'numero_clientes': numeroClientes,
      'visitados': visitados,
      'exitosos': exitosos,
      'no_exitosos': noExitosos,
      'pendiente': pendiente,
      'monto_total': montoTotal,
      'id_usuario': idUsuario,
    };
  }
}
