class Producto {
  int? idProducto;
  String nombre;
  String? imagen;
  String? unidMedida;
  int cantidad;
  double? descuento;
  double precio;

  Producto({
    this.idProducto,
    required this.nombre,
    this.imagen,
    this.unidMedida,
    required this.cantidad,
    this.descuento,
    required this.precio,
  });

  // Convertir desde Map (SQLite)
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      idProducto:
          map['id_producto'] ?? map['id_p_carrito'] ?? map['id_p_recibo'],
      nombre: map['nombre'],
      imagen: map['imagen'],
      unidMedida: map['unid_medida'],
      cantidad: map['cantidad'],
      descuento: map['descuento']?.toDouble(),
      precio: map['precio']?.toDouble(),
    );
  }

  // Convertir a Map para producto_carrito (SQLite)
  Map<String, dynamic> toCarritoMap() {
    return {
      'id_p_carrito': idProducto,
      'nombre': nombre,
      'imagen': imagen,
      'unid_medida': unidMedida,
      'cantidad': cantidad,
      'descuento': descuento,
      'precio': precio,
    };
  }

  // Convertir a Map para producto_recibo (SQLite)
  Map<String, dynamic> toReciboMap() {
    return {
      'id_p_recibo': idProducto,
      'nombre': nombre,
      'unid_medida': unidMedida,
      'cantidad': cantidad,
      'descuento': descuento,
      'precio': precio,
    };
  }

  @override
  String toString() {
    return 'Producto{idProducto: $idProducto, nombre: $nombre, cantidad: $cantidad, precio: $precio}';
  }
}
