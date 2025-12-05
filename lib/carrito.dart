import 'package:flutter/material.dart';
import 'productos.dart';

// En esta versión novato simple el carrito solo recibe un producto cuando se abre.
// Para mantenerlo simple usamos una lista fija dentro de la pantalla.
class CarritoPage extends StatefulWidget {
  final Producto? addProduct;
  CarritoPage({this.addProduct});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  // lista local del carrito
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    if (widget.addProduct != null) {
      items.add({'producto': widget.addProduct!, 'qty': 1});
    }
  }

  void add(Producto p) {
    // si el producto ya está, sumamos qty
    final idx = items.indexWhere((e) => e['producto'].nombre == p.nombre);
    if (idx >= 0) {
      setState(() => items[idx]['qty'] += 1);
    } else {
      setState(() => items.add({'producto': p, 'qty': 1}));
    }
  }

  void removeAt(int index) {
    setState(() => items.removeAt(index));
  }

  int total() {
    int t = 0;
    for (var it in items) {
      t += it['producto'].precio * it['qty'];
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(title: Text('Carrito'), backgroundColor: primary),
      body: items.isEmpty ? Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('assets/images/carrito_vacio.png', width: 140),
          SizedBox(height: 12),
          Text('Tu carrito está vacío', style: TextStyle(color: Colors.black54)),
        ]),
      ) : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final it = items[i];
                final p = it['producto'] as Producto;
                final qty = it['qty'] as int;
                return Container(
                  margin: EdgeInsets.only(bottom:10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 6)]),
                  child: Row(
                    children: [
                      Image.asset(p.imagen, width: 70, height: 70),
                      SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(p.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${p.precio} COP', style: TextStyle(color: Colors.black54))
                      ])),
                      Row(children: [
                        IconButton(onPressed: () {
                          setState(() {
                            if (it['qty'] > 1) it['qty'] -= 1;
                          });
                        }, icon: Icon(Icons.remove)),
                        Text(qty.toString()),
                        IconButton(onPressed: () {
                          setState(() { it['qty'] += 1; });
                        }, icon: Icon(Icons.add)),
                      ]),
                      IconButton(onPressed: () => removeAt(i), icon: Icon(Icons.delete, color: Colors.red))
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 8)]),
            child: Row(
              children: [
                Expanded(child: Text('Total: ${total()} COP', style: TextStyle(fontWeight: FontWeight.bold))),
                ElevatedButton(
                  onPressed: () {
                    // simulación de pago
                    showDialog(context: context, builder: (_) => AlertDialog(
                      title: Text('Pagar'),
                      content: Text('Pago simulado. Total: ${total()} COP'),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                    ));
                  },
                  child: Text('Pagar'),
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
