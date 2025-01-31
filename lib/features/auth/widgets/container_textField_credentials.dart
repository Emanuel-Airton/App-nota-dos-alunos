import 'package:flutter/material.dart';
import 'package:flutter_app/theme/custom_textField.dart';

// ignore: must_be_immutable
class ContainerTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String hintText;
  ContainerTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  State<ContainerTextField> createState() => _ContainerTextFieldState();
}

class _ContainerTextFieldState extends State<ContainerTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(widget.hintText != "senha" ? Icons.email : Icons.lock,
              color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Preencha o campo ${widget.hintText}";
                  } else {
                    return null;
                  }
                },
                keyboardType: widget.hintText != "senha"
                    ? TextInputType.emailAddress
                    : TextInputType.visiblePassword,
                controller: widget.controller,
                obscureText: widget.hintText != "senha" ? false : true,
                // autofocus: true,
                decoration: CustomTextField.textField(hint: widget.hintText)),
          ),
        ],
      ),
    );
  }
}
