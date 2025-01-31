import 'package:flutter/material.dart';

class SnackBarWidget {
  snackbar(BuildContext context) {
    return SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: const Center(child: Text('Erro ao tentar salvar a nota!')));
  }
}
