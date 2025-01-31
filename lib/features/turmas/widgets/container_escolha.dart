import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore: must_be_immutable
class ContainerEscolha extends StatefulWidget {
  late String texto;
  late Function()? onTap;
  ContainerEscolha({super.key, required this.texto, required this.onTap});

  @override
  State<ContainerEscolha> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ContainerEscolha> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
          ],
        ),
        child: Center(
          child: Text(widget.texto, style: CustomTextStyle.bodySmallHorario),
        ),
      ),
    );
  }
}
