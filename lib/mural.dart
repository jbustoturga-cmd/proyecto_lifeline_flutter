import 'package:flutter/material.dart';

class Post {
  String user;
  String text;
  String image;
  int likes;
  List<String> comments;

  Post({required this.user, required this.text, required this.image, this.likes = 0, List<String>? comments})
      : this.comments = comments ?? [];
}

class MuralPage extends StatefulWidget {
  @override
  State<MuralPage> createState() => _MuralPageState();
}

class _MuralPageState extends State<MuralPage> {
  List<Post> posts = [
    Post(user: 'Ana', text: 'Hoy me siento fuerte 💪', image: 'assets/images/post1.png', likes: 3),
    Post(user: 'Carlos', text: 'Nunca pierdas la esperanza', image: 'assets/images/post2.png', likes: 5),
    Post(user: 'María', text: 'Pequeños pasos, gran avance', image: 'assets/images/post3.png', likes: 2),
  ];

  final commentCtrls = <int, TextEditingController>{};

  @override
  void dispose() {
    commentCtrls.forEach((k, v) => v.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Color(0xFF4A90E2);
    return Scaffold(
      appBar: AppBar(title: Text('Mural motivacional'), backgroundColor: primary),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final p = posts[index];
          commentCtrls.putIfAbsent(index, () => TextEditingController());
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: primary.withOpacity(0.06), blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage('assets/images/avatar.png')),
                    SizedBox(width: 8),
                    Text(p.user, style: TextStyle(fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text('${p.likes} ❤', style: TextStyle(color: Colors.black54)),
                  ],
                ),
                SizedBox(height: 8),
                Text(p.text),
                SizedBox(height: 8),
                if (p.image.isNotEmpty)
                  ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(p.image)),
                SizedBox(height: 8),
                // actions
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() => p.likes += 1);
                      },
                      icon: Image.asset('assets/images/like_icon.png', width: 18),
                      label: Text('Like'),
                    ),
                    SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {
                        // abrir o enfocar campo comentario (simple)
                      },
                      icon: Image.asset('assets/images/comment_icon.png', width: 18),
                      label: Text('Comentar'),
                    ),
                  ],
                ),
                // comentarios existentes
                if (p.comments.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: p.comments.map((c) => Padding(
                      padding: const EdgeInsets.symmetric(vertical:4.0),
                      child: Text('- ' + c, style: TextStyle(color: Colors.black87)),
                    )).toList(),
                  ),
                // campo para comentar
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentCtrls[index],
                        decoration: InputDecoration(hintText: 'Escribe un comentario'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: primary),
                      onPressed: () {
                        final text = commentCtrls[index]!.text;
                        if (text.isNotEmpty) {
                          setState(() {
                            p.comments.add(text);
                            commentCtrls[index]!.clear();
                          });
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
