import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/routes/routes.dart';

// ignore: must_be_immutable
class ContainerProfile extends StatefulWidget {
  late Icon icon;
  late String texto;
  late String textoTop;
  late String route;

  ContainerProfile(
      {super.key,
      required this.icon,
      required this.texto,
      required this.textoTop,
      required this.route});

  @override
  State<ContainerProfile> createState() => _ContainerProfileState();
}

class _ContainerProfileState extends State<ContainerProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(widget.textoTop, style: CustomTextStyle.bodySmall),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
              ],
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.icon,
                Text(
                  widget.texto,
                  style: CustomTextStyle.bodySmall,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          Routes().generateRoutes(
                              RouteSettings(name: widget.route)));
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
