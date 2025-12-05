import 'package:flutter/material.dart';
import 'home.dart';
import 'registro.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void login() {
    // Simulación simple: si hay texto, entra
    if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(userName: emailCtrl.text)),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Ingrese correo y contraseña'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset('assets/images/logo.png', height: 100),
              SizedBox(height: 18),
              Text('Life Line', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: primary)),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: primary.withOpacity(0.15), blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailCtrl,
                      decoration: InputDecoration(labelText: 'Correo', prefixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passCtrl,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Contraseña', prefixIcon: Icon(Icons.lock)),
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: primary),
                            onPressed: login,
                            child: Text('Iniciar sesión'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => RegistroPage()));
                      },
                      child: Text('Crear cuenta'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
