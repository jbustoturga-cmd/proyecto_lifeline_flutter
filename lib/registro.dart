// lib/registro.dart
import 'package:flutter/material.dart';
import 'login.dart';

class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    nombreCtrl.dispose();
    correoCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _registrar() {
    if (nombreCtrl.text.isNotEmpty && correoCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      // Simple: volvemos al login simulando éxito
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Cuenta creada'),
          content: Text('Cuenta para ${nombreCtrl.text} creada correctamente.'),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // vuelve al login
            }, child: Text('OK'))
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complete todos los campos')));
    }
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
                Text("Crear cuenta", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primary)),
                SizedBox(height: 18),

                TextField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: "Nombre completo", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                ),

                SizedBox(height: 12),

                TextField(
                  controller: correoCtrl,
                  decoration: InputDecoration(labelText: "Correo", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                ),

                SizedBox(height: 12),

                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Contraseña", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                ),

                SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registrar,
                    style: ElevatedButton.styleFrom(backgroundColor: primary, padding: EdgeInsets.symmetric(vertical:14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Text("Registrarse", style: TextStyle(fontSize:16)),
                  ),
                ),

                SizedBox(height: 10),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("¿Ya tienes cuenta? Iniciar sesión"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
