import 'package:flutter/material.dart';
import 'package:flutter_app/features/auth/services/auth_service.dart';
import 'package:flutter_app/features/auth/views/login_page.dart';

// ignore: must_be_immutable
class PopupMenuButtonHomePage extends StatelessWidget {
  List<String> list;
  PopupMenuButtonHomePage({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        await AuthService().sigoutFirebaseAuth();
        await AuthService().preferencesRemove();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      icon: const Icon(
        size: 30,
        Icons.account_circle,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return list.map((e) {
          return PopupMenuItem(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(e.toString()),
                  const Icon(
                    Icons.logout,
                    color: Colors.black,
                  )
                ],
              ));
        }).toList();
      },
    );
  }
}
