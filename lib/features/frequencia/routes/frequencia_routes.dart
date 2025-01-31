import 'package:flutter/material.dart';
import 'package:flutter_app/features/frequencia/views/page_frequencia.dart';

Map<String, Widget Function(BuildContext context, RouteSettings)> map = {
  'frequencia': ((context, p1) => const PageFrequencia())
};
