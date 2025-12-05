import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 850,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // FOTO
                CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),

                const SizedBox(height: 16),

                // NOMBRE
                Text(
                  "Usuario Life Line",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),

                const SizedBox(height: 6),

                // EMAIL
                Text(
                  "usuario@lifeline.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 25),

                // CINTA
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Mi progreso en Life Line",
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // ESTADÍSTICAS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statBox("Compras", "12"),
                    _statBox("Likes", "57"),
                    _statBox("Comentarios", "23"),
                  ],
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Configuración",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                _configButton(Icons.lock, "Cambiar contraseña"),
                _configButton(Icons.notifications, "Notificaciones"),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // CAJA ESTADÍSTICA
  Widget _statBox(String titulo, String valor) {
    return Column(
      children: [
        Text(
          valor,
          style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          titulo,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // BOTÓN CONFIGURACIÓN
  Widget _configButton(IconData icon, String texto) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 28),
          const SizedBox(width: 12),
          Text(
            texto,
            style: TextStyle(
              fontSize: 17,
              color: Colors.blue.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
