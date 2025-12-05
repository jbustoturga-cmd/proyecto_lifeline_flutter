import 'package:flutter/material.dart';
import 'productos.dart';
import 'carrito.dart';
import 'mural.dart';
import 'perfil.dart';
import 'tienda.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xFF4A90E2);
    final double maxContentWidth = 980;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        centerTitle: true,
        title: Text(
          "Life Line",
          style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilPage())),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/avatar.png'),
                onBackgroundImageError: (_, __) {}, // evita crash si la imagen falta
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              children: [
                // Header card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))],
                  ),
                  child: Row(
                    children: [
                      // Logo (maneja error si no existe)
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, obj, stack) => Container(color: Colors.grey[200]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Hola, usuario@example.com", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 6),
                            Text("Bienvenido a Life Line — apoyo, tienda y comunidad.", style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Row de botones principales (responsive)
                LayoutBuilder(builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 700;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _navCard(context, icon: Icons.image, label: 'Mural', page: const MuralPage(), width: isNarrow ? 160 : 200, color: primary),
                      _navCard(context, icon: Icons.storefront, label: 'Tienda', page: TiendaPage(), width: isNarrow ? 160 : 200, color: primary),
                      _navCard(context, icon: Icons.shopping_cart, label: 'Carrito', page: const CarritoPage(), width: isNarrow ? 160 : 200, color: primary),
                      _navCard(context, icon: Icons.person, label: 'Perfil', page: const PerfilPage(), width: isNarrow ? 160 : 200, color: primary),
                    ],
                  );
                }),

                const SizedBox(height: 18),

                // Grid de productos (preview) dentro de Expanded para evitar overflow
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: listaProductos.isEmpty
                        ? Center(child: Text("No hay productos disponibles", style: TextStyle(color: Colors.black54)))
                        : GridView.builder(
                            padding: const EdgeInsets.only(top: 6),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : (MediaQuery.of(context).size.width > 800 ? 3 : 2),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.72,
                            ),
                            itemCount: listaProductos.length,
                            itemBuilder: (context, i) {
                              final p = listaProductos[i];
                              return _productCard(context, p);
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navCard(BuildContext context, {required IconData icon, required String label, required Widget page, required double width, required Color color}) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
        child: Container(
          width: width,
          height: 118,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productCard(BuildContext context, dynamic p) {
    // Si p no tiene los campos esperados, evita crash mostrando placeholder
    final nombre = (p?.nombre ?? 'Producto');
    final imagen = (p?.imagen ?? 'assets/images/carrito_vacio.png');
    final precio = (p?.precio ?? 0);

    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              imagen,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(height: 140, color: Colors.grey[200]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text('$precio COP', style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // navegación al carrito pasando producto
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CarritoPage(addProduct: p)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Agregar al carrito'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
