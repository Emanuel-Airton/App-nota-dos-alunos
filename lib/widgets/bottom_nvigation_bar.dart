import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/views/home_page.dart';
import 'package:flutter_app/features/horario/horario_view.dart';
import 'package:flutter_app/features/profile/views/profile_view.dart';

class BottomNavigationBar2 extends StatefulWidget {
  const BottomNavigationBar2({super.key});

  @override
  State<BottomNavigationBar2> createState() => _BottomNavigationBar2State();
}

class _BottomNavigationBar2State extends State<BottomNavigationBar2> {
  int _selectIndex = 0;
  List<Widget> list = [
    const HomePage(),
    const HorarioView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_selectIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFEFEFEF),
        onDestinationSelected: (value) {
          setState(() {
            _selectIndex = value;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.primary,
        selectedIndex: _selectIndex,
        overlayColor: const MaterialStatePropertyAll(Colors.white),
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: 'Home',
            selectedIcon: Icon(Icons.home,
                color: Theme.of(context).colorScheme.background),
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month),
            label: 'Horario de aula',
            selectedIcon: Icon(Icons.calendar_month,
                color: Theme.of(context).colorScheme.background),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: 'usuario',
            selectedIcon: Icon(Icons.person,
                color: Theme.of(context).colorScheme.background),
          ),
        ],
      ),
    );
  }
}
