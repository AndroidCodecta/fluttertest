class ProductoRecibo {
  int? idPRecibo;
  String nombre;
  String? unidMedida;
  int cantidad;
  double? descuento;
  double precio;
  int idRecibo;

  ProductoRecibo({
    this.idPRecibo,
    required this.nombre,
    this.unidMedida,
    required this.cantidad,
    this.descuento,
    required this.precio,
    required this.idRecibo,
  });

  factory ProductoRecibo.fromMap(Map<String, dynamic> map) {
    return ProductoRecibo(
      idPRecibo: map['id_p_recibo'],
      nombre: map['nombre'],
      unidMedida: map['unid_medida'],
      cantidad: map['cantidad'],
      descuento: map['descuento']?.toDouble(),
      precio: map['precio'].toDouble(),
      idRecibo: map['id_recibo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_p_recibo': idPRecibo,
      'nombre': nombre,
      'unid_medida': unidMedida,
      'cantidad': cantidad,
      'descuento': descuento,
      'precio': precio,
      'id_recibo': idRecibo,
    };
  }
}
