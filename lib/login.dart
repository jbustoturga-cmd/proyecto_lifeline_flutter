// lib/login.dart
import 'package:flutter/material.dart';
import 'registro.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final correoCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    correoCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4A90E2);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 18, offset: Offset(0,6))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Life Line", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primary)),
                SizedBox(height: 8),
                Text("Inicia sesión para continuar", style: TextStyle(color: Colors.black54)),
                SizedBox(height: 22),

                TextField(
                  controller: correoCtrl,
                  decoration: InputDecoration(
                    labelText: "Correo",
                    hintText: "correo@example.com",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical:12, horizontal:14),
                  ),
                ),

                SizedBox(height: 14),

                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    hintText: "••••••••",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical:12, horizontal:14),
                  ),
                ),

                SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // validación simple
                      if (correoCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complete correo y contraseña')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: EdgeInsets.symmetric(vertical:14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Iniciar sesión", style: TextStyle(fontSize:16)),
                  ),
                ),

                SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RegistroPage()));
                  },
                  child: Text("¿No tienes cuenta? Registrarse"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
