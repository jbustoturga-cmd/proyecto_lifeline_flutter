import 'package:flutter/material.dart';
import 'productos.dart';
import 'carrito.dart';

class TiendaPage extends StatefulWidget {
  const TiendaPage({super.key});

  @override
  State<TiendaPage> createState() => _TiendaPageState();
}

class _TiendaPageState extends State<TiendaPage> {
  String filtro = "Todos";
  String busqueda = "";

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4A90E2);

    List<String> categorias = ["Todos", "Cuidado", "Ropa", "Vitaminas"];

    List<Producto> filtrado = listaProductos.where((p) {
      bool coincideFiltro =
          filtro == "Todos" ||
          (filtro == "Cuidado" && p.nombre.contains("Crema") || p.nombre.contains("Gel")) ||
          (filtro == "Ropa" && p.nombre.contains("Camiseta") || p.nombre.contains("Gorra")) ||
          (filtro == "Vitaminas" && p.nombre.contains("Vitamina"));

      bool coincideBuscar = p.nombre.toLowerCase().contains(busqueda.toLowerCase());

      return coincideFiltro && coincideBuscar;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tienda"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CarritoPage()),
            ),
          )
        ],
      ),

      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // BUSCADOR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar producto...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (txt) => setState(() => busqueda = txt),
                ),
              ),

              const SizedBox(height: 12),

              // CATEGORÍAS
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categorias.length,
                  itemBuilder: (_, i) {
                    final c = categorias[i];
                    final activo = filtro == c;

                    return GestureDetector(
                      onTap: () => setState(() => filtro = c),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: activo ? primary : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          c,
                          style: TextStyle(
                            color: activo ? Colors.white : Colors.black87,
                            fontWeight: activo ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // PRODUCTOS
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtrado.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 1100
                        ? 4
                        : MediaQuery.of(context).size.width > 800
                            ? 3
                            : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, i) {
                    final p = filtrado[i];
                    return _productoCard(context, p, primary);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productoCard(BuildContext context, Producto p, Color primary) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Image.asset(
                p.imagen,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 140, color: Colors.grey[300]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.nombre, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("${p.precio} COP", style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  const SizedBox(height: 12),

                  // BOTÓN DE AGREGAR
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CarritoPage(addProduct: p)),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      label: const Text("Agregar"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
