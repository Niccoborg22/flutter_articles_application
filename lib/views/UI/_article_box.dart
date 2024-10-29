import 'package:flutter/material.dart';

// ARTICLE DISPLAY BOX
class ArticleBox extends StatelessWidget {
  const ArticleBox({
    super.key,
    required this.title,
    required this.article,
  });

  final String article;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(129, 211, 211, 211),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Text(title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),),
          Text(article),
        ],
      ),
    );
  }
}