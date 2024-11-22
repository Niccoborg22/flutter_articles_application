import 'package:flutter/material.dart';
import '../_login.dart';
import '_title.dart';

class TitleBar extends StatelessWidget {
  final String titlePage;

  const TitleBar({
    super.key,
    required this.titlePage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageTitle(title: titlePage),
        Column(
          children: [
            IconButton(
                onPressed: () {
                  // Navigate to LoginPage here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout)),
            const Text("Logout")
          ],
        )
      ],
    );
  }
}