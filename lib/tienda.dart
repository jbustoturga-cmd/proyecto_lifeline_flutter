import 'package:flutter/material.dart';
import 'productos.dart';
import 'carrito.dart';

class TiendaPage extends StatefulWidget {
  @override
  State<TiendaPage> createState() => _TiendaPageState();
}

class _TiendaPageState extends State<TiendaPage> {
  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(title: Text('Tienda'), backgroundColor: primary),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: listaProductos.length,
        itemBuilder: (context, i) {
          final p = listaProductos[i];
          return Container(
            margin: EdgeInsets.only(bottom:10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 6)]
            ),
            child: Row(
              children: [
                Image.asset(p.imagen, width: 80, height: 80),
                SizedBox(width: 10),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(p.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height:4),
                    Text('${p.precio} COP', style: TextStyle(color: Colors.black54))
                  ]),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Añadir al carrito - uso Navigator para enviar datos al carrito
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CarritoPage(addProduct: p)));
                      },
                      child: Text('Agregar'),
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
