import 'package:flutter/material.dart';

import 'models/device_item.dart';
import 'models/local_account.dart';
import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/register_page.dart';
import 'routes.dart';

void main() => runApp(const ElectronicDevicesApp());

class ElectronicDevicesApp extends StatefulWidget {
  const ElectronicDevicesApp({super.key, this.account});

  final LocalAccount? account;

  @override
  State<ElectronicDevicesApp> createState() => _ElectronicDevicesAppState();
}

class _ElectronicDevicesAppState extends State<ElectronicDevicesApp> {
  late final LocalAccount _account;

  @override
  void initState() {
    super.initState();
    _account = widget.account ?? LocalAccount();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Электронные устройства',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.loading,
      routes: {
        Routes.loading: (_) => const LoadingPage(),
        Routes.login: (_) => LoginPage(account: _account),
        Routes.register: (_) => RegisterPage(account: _account),
        Routes.home: (_) => const HomePage(),
        Routes.profile: (_) => ProfilePage(account: _account),
      },
      onGenerateRoute: (settings) {
        if (settings.name == Routes.detail &&
            settings.arguments is DeviceItem) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) =>
                DetailPage(device: settings.arguments! as DeviceItem),
          );
        }
        return null;
      },
    );
  }
}
