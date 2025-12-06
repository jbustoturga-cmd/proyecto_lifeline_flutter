// lib/mural.dart
import 'package:flutter/material.dart';

class Post {
  String user;
  String text;
  String? image;
  int likes;
  List<String> comments;

  Post({
    required this.user,
    required this.text,
    this.image,
    this.likes = 0,
    List<String>? comments,
  }) : comments = comments ?? [];
}

class MuralPage extends StatefulWidget {
  const MuralPage({super.key});

  @override
  State<MuralPage> createState() => _MuralPageState();
}

class _MuralPageState extends State<MuralPage> {
  final posts = <Post>[
    Post(user: 'Ana', text: 'Hoy me siento fuerte 💪', image: 'assets/images/post1.png', likes: 3),
    Post(user: 'Carlos', text: 'Nunca pierdas la esperanza', image: 'assets/images/post2.png', likes: 5),
    Post(user: 'María', text: 'Pequeños pasos, gran avance', image: 'assets/images/post3.png', likes: 2),
  ];

  final commentCtrls = <int, TextEditingController>{};

  @override
  void dispose() {
    for (final c in commentCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4A90E2);

    return Scaffold(
      backgroundColor: const Color(0xFFE8F3FF), // azul claro suave
      appBar: AppBar(
        title: const Text('Mural motivacional'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Center(
        child: Container(
          width: 800, // tamaño ideal centrado
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 14,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final p = posts[i];
              commentCtrls.putIfAbsent(i, () => TextEditingController());

              return Container(
                margin: const EdgeInsets.only(bottom: 26),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header usuario
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                          radius: 22,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          p.user,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        Text(
                          '${p.likes} ❤️',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Text(
                      p.text,
                      style: const TextStyle(fontSize: 15),
                    ),

                    // Imagen del post
                    if (p.image != null) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          p.image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                          errorBuilder: (_, __, ___) => Container(
                            height: 200,
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Botones Like & comentar
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () => setState(() => p.likes++),
                          icon: Image.asset(
                            'assets/images/like_icon.png',
                            width: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.favorite, color: Colors.red, size: 20),
                          ),
                          label: const Text('Like'),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/comment_icon.png',
                            width: 20,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.comment, size: 20),
                          ),
                          label: const Text('Comentar'),
                        ),
                      ],
                    ),

                    // Comentarios
                    if (p.comments.isNotEmpty)
                      ...p.comments.map((c) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text('- $c'),
                          )),

                    const SizedBox(height: 8),

                    // Caja para comentar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentCtrls[i],
                            decoration: InputDecoration(
                              hintText: 'Escribe un comentario...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            final text = commentCtrls[i]!.text.trim();
                            if (text.isEmpty) return;
                            setState(() {
                              p.comments.add(text);
                              commentCtrls[i]!.clear();
                            });
                          },
                          icon: Icon(Icons.send, color: primary),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
