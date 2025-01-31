import 'package:flutter/material.dart';

class ContainerImage extends StatefulWidget {
  const ContainerImage({super.key});

  @override
  State<ContainerImage> createState() => _ContainerImageState();
}

class _ContainerImageState extends State<ContainerImage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      height: size.width * 0.6,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/dirio_books_1_removebg_preview_11.png',
          ),
        ),
      ),
    );
  }
}
