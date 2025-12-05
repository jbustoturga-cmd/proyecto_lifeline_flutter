import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nombre = 'Usuario';
  String estado = 'Hoy me siento bien';

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(title: Text('Mi perfil'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 8)]
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 36, backgroundImage: AssetImage('assets/images/avatar.png')),
                  SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(nombre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(estado, style: TextStyle(color: Colors.black54)),
                  ])
                ],
              ),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Editar perfil'),
              onTap: () {
                _editPerfilDialog();
              },
            ),
            ListTile(leading: Icon(Icons.logout), title: Text('Cerrar sesión'), onTap: () {
              Navigator.pop(context);
            })
          ],
        ),
      ),
    );
  }

  void _editPerfilDialog() {
    final nameCtrl = TextEditingController(text: nombre);
    final statusCtrl = TextEditingController(text: estado);

    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('Editar perfil'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Nombre')),
        TextField(controller: statusCtrl, decoration: InputDecoration(labelText: 'Estado')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
        TextButton(onPressed: () {
          setState(() {
            nombre = nameCtrl.text;
            estado = statusCtrl.text;
          });
          Navigator.pop(context);
        }, child: Text('Guardar'))
      ],
    ));
  }
}
