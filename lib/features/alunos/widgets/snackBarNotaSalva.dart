import 'package:flutter/material.dart';

class SnackBarNotaSalva {
  snackbar(BuildContext context) {
    return SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        content: const Center(child: Text('nota salva com sucesso!')));
  }
}
