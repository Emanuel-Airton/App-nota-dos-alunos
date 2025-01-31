import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtomCalculaMedia extends StatefulWidget {
  late double media;
  ButtomCalculaMedia({super.key, required this.media});

  @override
  State<ButtomCalculaMedia> createState() => _ButtomCalculaMediaState();
}

class _ButtomCalculaMediaState extends State<ButtomCalculaMedia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: const Color(0xFFED6969)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFEFEFEF),
      ),
      child: TextButton(
        onPressed: () {
          widget.media;
        },
        child: const Text("calcular média"),
      ),
    );
  }
}
