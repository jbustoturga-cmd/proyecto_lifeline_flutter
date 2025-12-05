import 'package:flutter/material.dart';
import 'mural.dart';
import 'perfil.dart';
import 'tienda.dart';
import 'carrito.dart';
import 'future.dart';

class HomePage extends StatelessWidget {
  final String userName;
  HomePage({this.userName = 'Usuario'});

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Life Line'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PerfilPage())),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Banner con welcome (Row + Expanded + Flexible)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: primary.withOpacity(0.07), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Flexible(
                    flex: 0,
                    child: Image.asset('assets/images/logo.png', height: 64),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hola, $userName', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        Text('Bienvenido a Life Line — apoyo y productos para tu cuidado.',
                            style: TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12),
            // Grid de opciones (Row + Flexible)
            Row(
              children: [
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    icon: Icon(Icons.forum),
                    label: Text('Mural'),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MuralPage())),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    icon: Icon(Icons.store),
                    label: Text('Tienda'),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TiendaPage())),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    icon: Icon(Icons.shopping_cart),
                    label: Text('Carrito'),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CarritoPage())),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    icon: Icon(Icons.access_time),
                    label: Text('Cargar dato'),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FuturePage())),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Quick cards (ListView horizontal) - ejemplo sencillo
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  quickCard('Consejo', 'Pequeños pasos cada día', 'assets/images/post1.png'),
                  quickCard('Comodidad', 'Ropa suave', 'assets/images/camiseta.png'),
                  quickCard('Cuidado', 'Protector solar', 'assets/images/gorra.png'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget quickCard(String title, String subtitle, String img) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Color(0xFF4A90E2).withOpacity(0.08), blurRadius: 6)]),
      child: Row(
        children: [
          Image.asset(img, width: 56, height: 56),
          SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black54))
          ]))
        ],
      ),
    );
  }
}
