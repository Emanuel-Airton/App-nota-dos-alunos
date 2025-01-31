import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/alunos/provider/alunos_notas_provider.dart';
import 'package:flutter_app/features/alunos/provider/notas_firebase_provider.dart';
import 'package:flutter_app/features/auth/provider/auth_user_provider.dart';
import 'package:flutter_app/features/frequencia/provider/frequencia_provider.dart';
import 'package:flutter_app/features/profile/provider/profile_provider.dart';
import 'package:flutter_app/pages/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((_) => AuthUserProvider())),
      ChangeNotifierProvider(create: ((_) => ProfileProvider())),
      ChangeNotifierProvider(create: ((_) => AlunosNotasProvider())),
      ChangeNotifierProvider(create: ((_) => AlunosfirestoreProvider())),
      ChangeNotifierProvider(create: ((_) => FrequenciaProvider())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: const Scaffold(
        body: SplashScreen(),
      ),
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        colorScheme: ColorScheme.fromSeed(
            // secondary: const Color.fromARGB(255, 0, 0, 128),
            primary: const Color(0xFFED6969),
            onSecondaryContainer: const Color.fromARGB(255, 37, 117, 238),
            seedColor: const Color.fromRGBO(237, 105, 105, 1),
            background: Colors.white),
        useMaterial3: true,
      ),
    );
  }
}
//Color.fromRGBO(237, 105, 105, 1)