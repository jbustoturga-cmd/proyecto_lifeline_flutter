// Lista simple de productos en Dart (archivo simple para novato)
class Producto {
  String nombre;
  String imagen;
  int precio;

  Producto(this.nombre, this.imagen, this.precio);
}

List<Producto> listaProductos = [
  Producto("Crema hidratante", "assets/images/crema.png", 30000),
  Producto("Gorra UV", "assets/images/gorra.png", 25000),
  Producto("Camiseta suave", "assets/images/camiseta.png", 40000),
  Producto("Suplemento natural", "assets/images/suplemento.png", 35000),
  Producto("Proteína alta", "assets/images/proteina.png", 45000),
  Producto("Vitamina B12", "assets/images/vitamina.png", 20000),
  Producto("Gel calmante", "assets/images/gel.png", 28000),
];
