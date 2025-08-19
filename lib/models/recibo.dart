class Recibo {
  int? idRecibo;
  String? empresa;
  String numeroRecibo;
  String fecha;
  String? ruc;
  String? tipoRecibo;
  double? subtotal;
  double? descuento;
  double? igv;
  double? total;
  int idClientes;

  Recibo({
    this.idRecibo,
    this.empresa,
    required this.numeroRecibo,
    required this.fecha,
    this.ruc,
    this.tipoRecibo,
    this.subtotal,
    this.descuento,
    this.igv,
    this.total,
    required this.idClientes,
  });

  factory Recibo.fromMap(Map<String, dynamic> map) {
    return Recibo(
      idRecibo: map['id_recibo'],
      empresa: map['empresa'],
      numeroRecibo: map['numero_recibo'],
      fecha: map['fecha'],
      ruc: map['ruc'],
      tipoRecibo: map['tipo_recibo'],
      subtotal: map['subtotal']?.toDouble(),
      descuento: map['descuento']?.toDouble(),
      igv: map['igv']?.toDouble(),
      total: map['total']?.toDouble(),
      idClientes: map['id_clientes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_recibo': idRecibo,
      'empresa': empresa,
      'numero_recibo': numeroRecibo,
      'fecha': fecha,
      'ruc': ruc,
      'tipo_recibo': tipoRecibo,
      'subtotal': subtotal,
      'descuento': descuento,
      'igv': igv,
      'total': total,
      'id_clientes': idClientes,
    };
  }
}
