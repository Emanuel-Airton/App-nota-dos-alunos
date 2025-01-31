import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleAvatarNumber extends StatelessWidget {
  late int cont;
  CircleAvatarNumber({super.key, required this.cont});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Text(
        cont.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
