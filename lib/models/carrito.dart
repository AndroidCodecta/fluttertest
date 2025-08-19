class ProductoCarrito {
  int? idPCarrito;
  String nombre;
  String? imagen;
  String? unidMedida;
  int cantidad;
  double? descuento;
  double precio;
  int idClientes;

  ProductoCarrito({
    this.idPCarrito,
    required this.nombre,
    this.imagen,
    this.unidMedida,
    required this.cantidad,
    this.descuento,
    required this.precio,
    required this.idClientes,
  });

  factory ProductoCarrito.fromMap(Map<String, dynamic> map) {
    return ProductoCarrito(
      idPCarrito: map['id_p_carrito'],
      nombre: map['nombre'],
      imagen: map['imagen'],
      unidMedida: map['unid_medida'],
      cantidad: map['cantidad'],
      descuento: map['descuento']?.toDouble(),
      precio: map['precio'].toDouble(),
      idClientes: map['id_clientes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_p_carrito': idPCarrito,
      'nombre': nombre,
      'imagen': imagen,
      'unid_medida': unidMedida,
      'cantidad': cantidad,
      'descuento': descuento,
      'precio': precio,
      'id_clientes': idClientes,
    };
  }
}
