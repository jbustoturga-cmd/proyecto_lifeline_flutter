import 'package:flutter/material.dart';

class FuturePage extends StatelessWidget {
  Future<String> fetchFrase() async {
    // simula una llamada remota
    await Future.delayed(Duration(seconds: 2));
    return 'Cada día es una nueva oportunidad 🌤️';
  }

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(title: Text('Cargando...'), backgroundColor: primary),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchFrase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(color: primary),
                SizedBox(height: 12),
                Text('Cargando frase...'),
              ]);
            } else if (snapshot.hasError) {
              return Text('Error al cargar');
            } else {
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 8)]),
                child: Text(snapshot.data ?? '', style: TextStyle(fontSize: 18)),
              );
            }
          },
        ),
      ),
    );
  }
}
