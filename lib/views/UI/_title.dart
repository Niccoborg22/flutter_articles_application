import 'package:flutter/material.dart';

// TITLE
class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: Theme.of(context,).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
    ));
  }
}
