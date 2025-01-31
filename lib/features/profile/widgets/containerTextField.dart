import 'package:flutter/material.dart';
import 'package:flutter_app/core/app_export.dart';
import 'package:flutter_app/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ContainerTextField extends StatefulWidget {
  late Icon icon;
  TextEditingController controller = TextEditingController();

  ContainerTextField({
    super.key,
    required this.icon,
    required this.controller,
  });

  @override
  State<ContainerTextField> createState() => _ContainerTextFieldState();
}

class _ContainerTextFieldState extends State<ContainerTextField> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    String? profile = provider.profileModel.userProfileName;
    debugPrint(profile ?? "vazio");
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            widget.icon,
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: CustomTextField.textField(hint: profile ?? ''),
                obscureText: profile == "senha" ? true : false,
                // autofocus: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
