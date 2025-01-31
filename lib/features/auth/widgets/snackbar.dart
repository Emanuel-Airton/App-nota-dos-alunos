import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SnackBarWidget {
  snackbar(BuildContext context, String texto) {
    return SnackBar(
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Center(child: Text(texto)));
  }
}
