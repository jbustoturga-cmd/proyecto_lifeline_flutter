// lib/future.dart
import 'package:flutter/material.dart';

class FuturePage extends StatelessWidget {
  final Color primary = const Color(0xFF4A90E2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Futuro del proyecto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ideas Futuristas 🧠🚀",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primary)),
              SizedBox(height: 12),
              Text(
                "• IA para recomendar productos personalizados.\n"
                "• Sistema de apoyo emocional con chat anónimo.\n"
                "• Rutinas de cuidado diarias.\n"
                "• Tienda con realidad aumentada.\n"
                "• Comunidad global de mensajes motivacionales.",
                style: TextStyle(fontSize: 16, height: 1.4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
