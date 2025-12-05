import 'package:flutter/material.dart';
import 'login.dart';

class RegistroPage extends StatefulWidget {
  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void registrar() {
    if (nameCtrl.text.isNotEmpty && emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Listo'),
          content: Text('Cuenta creada para ${nameCtrl.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complete todos los campos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(title: Text('Registro'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Nombre')),
            SizedBox(height: 8),
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Correo')),
            SizedBox(height: 8),
            TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Contraseña')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: registrar,
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(backgroundColor: primary),
            )
          ],
        ),
      ),
    );
  }
}
