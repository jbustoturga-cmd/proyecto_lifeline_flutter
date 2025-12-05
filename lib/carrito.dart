// lib/carrito.dart
import 'package:flutter/material.dart';
import 'productos.dart';

class CarritoPage extends StatefulWidget {
  final Producto? addProduct;

  const CarritoPage({super.key, this.addProduct});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    if (widget.addProduct != null) {
      // si viene un producto, lo agregamos con qty 1
      items.add({'producto': widget.addProduct!, 'qty': 1});
    }
  }

  void _addProducto(Producto p) {
    final idx = items.indexWhere((e) => e['producto'].nombre == p.nombre);
    if (idx >= 0) {
      setState(() => items[idx]['qty'] += 1);
    } else {
      setState(() => items.add({'producto': p, 'qty': 1}));
    }
  }

  void _removeAt(int index) => setState(() => items.removeAt(index));

  int _total() {
    int t = 0;
    for (var it in items) {
      final p = it['producto'] as Producto;
      final qty = it['qty'] as int;
      t += p.precio * qty;
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4A90E2);

    return Scaffold(
      appBar: AppBar(title: const Text('Carrito'), backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 0.8),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          padding: const EdgeInsets.all(16),
          child: items.isEmpty
              ? Column(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset('assets/images/carrito_vacio.png', width: 220, errorBuilder: (_,__,___) => const SizedBox.shrink()),
                  const SizedBox(height: 16),
                  const Text('Tu carrito está vacío', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ])
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, i) {
                          final it = items[i];
                          final p = it['producto'] as Producto;
                          final qty = it['qty'] as int;

                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:10, offset: Offset(0,4))]),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(p.imagen, width: 80, height: 80, fit: BoxFit.cover, errorBuilder: (_,__,___) => Container(width:80,height:80,color:Colors.grey[200])),
                                ),
                                const SizedBox(width: 12),
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(p.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height:6),
                                  Text('${p.precio} COP', style: const TextStyle(color: Colors.black54)),
                                ])),
                                Row(children: [
                                  IconButton(onPressed: () {
                                    setState(() {
                                      if (it['qty'] > 1) it['qty'] -= 1;
                                    });
                                  }, icon: const Icon(Icons.remove)),
                                  Text(qty.toString()),
                                  IconButton(onPressed: () {
                                    setState(() { it['qty'] += 1; });
                                  }, icon: const Icon(Icons.add)),
                                ]),
                                IconButton(onPressed: () => _removeAt(i), icon: const Icon(Icons.delete, color: Colors.red)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top:12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius:10, offset: Offset(0,-2))]),
                      child: Row(
                        children: [
                          Expanded(child: Text('Total: ${_total()} COP', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(context: context, builder: (_) => AlertDialog(
                                title: const Text('Pagar'),
                                content: Text('Pago simulado. Total: ${_total()} COP'),
                                actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                              ));
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: primary, padding: const EdgeInsets.symmetric(vertical:12,horizontal:18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            child: const Text('Pagar'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
      floatingActionButton: items.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // ejemplo: vaciar carrito
                setState(() => items.clear());
              },
              backgroundColor: primary,
              child: const Icon(Icons.delete),
            )
          : null,
    );
  }
}
