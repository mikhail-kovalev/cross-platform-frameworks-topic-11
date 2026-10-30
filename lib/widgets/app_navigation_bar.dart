import 'package:flutter/material.dart';

import '../routes.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    this.fromDetail = false,
  });

  final int selectedIndex;
  final bool fromDetail;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (fromDetail && index == 0) {
          Navigator.pop(context);
        } else if (index != selectedIndex || fromDetail) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            index == 0 ? Routes.home : Routes.profile,
            (_) => false,
          );
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: Colors.blue),
          label: 'Главная',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person, color: Colors.blue),
          label: 'Профиль',
        ),
      ],
    );
  }
}
