// lib/mural.dart
import 'package:flutter/material.dart';

class Post {
  String user;
  String text;
  String? image;
  int likes;
  List<String> comments;

  Post({required this.user, required this.text, this.image, this.likes = 0, List<String>? comments})
      : comments = comments ?? [];
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
    for (final c in commentCtrls.values) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF4A90E2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mural motivacional'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.8,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, i) {
              final p = posts[i];
              commentCtrls.putIfAbsent(i, () => TextEditingController());
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,4))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // header
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: const AssetImage('assets/images/avatar.png'),
                            radius: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(p.user, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text('${p.likes} ❤', style: const TextStyle(color: Colors.black54)),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Text(p.text),

                      if (p.image != null) ...[
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(p.image!, fit: BoxFit.cover, width: double.infinity, errorBuilder: (_,__,___) => Container(height:140, color: Colors.grey[200])),
                        ),
                      ],

                      const SizedBox(height: 8),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () => setState(() => p.likes += 1),
                            icon: Image.asset('assets/images/like_icon.png', width: 18, errorBuilder: (_,__,___) => Icon(Icons.favorite, size: 18, color: Colors.red)),
                            label: const Text('Like'),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: () {
                              // enfocar input
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            icon: Image.asset('assets/images/comment_icon.png', width: 18, errorBuilder: (_,__,___) => Icon(Icons.comment, size: 18)),
                            label: const Text('Comentar'),
                          ),
                        ],
                      ),

                      // comentarios existentes
                      if (p.comments.isNotEmpty) ...p.comments.map((c) => Padding(
                        padding: const EdgeInsets.symmetric(vertical:4.0),
                        child: Text('- $c', style: const TextStyle(color: Colors.black87)),
                      )) else const SizedBox.shrink(),

                      // campo agregar comentario
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentCtrls[i],
                              decoration: InputDecoration(
                                hintText: 'Escribe un comentario...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final text = commentCtrls[i]!.text.trim();
                              if (text.isEmpty) return;
                              setState(() {
                                p.comments.add(text);
                                commentCtrls[i]!.clear();
                              });
                            },
                            icon: const Icon(Icons.send, color: Color(0xFF4A90E2)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
