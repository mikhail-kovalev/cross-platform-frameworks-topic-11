import 'package:flutter/material.dart';

void main() {
  runApp(const ElectronicDevicesApp());
}

class ElectronicDevicesApp extends StatelessWidget {
  const ElectronicDevicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Электронные устройства',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2457C5)),
        scaffoldBackgroundColor: const Color(0xFFF3F6FC),
        useMaterial3: true,
      ),
      home: const ElectronicDevicesPage(),
    );
  }
}

class ElectronicDevicesPage extends StatelessWidget {
  const ElectronicDevicesPage({super.key});

  static const String studentName = 'Ковалев М.М.';
  static const String studentGroup = 'ИКБО-62-23';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        centerTitle: true,
        title: const Text(
          'Электронные устройства',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 680),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1800184D),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Смартфон',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Смартфон объединяет средства связи, камеру, навигацию '
                    'и доступ к цифровым сервисам в одном компактном корпусе.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, height: 1.45),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final bool isCompact = constraints.maxWidth < 520;
                    const Widget image = _DeviceImage();
                    const Widget features = _DeviceFeatureList();

                    if (isCompact) {
                      return const Column(
                        children: [
                          _DeviceImage(),
                          SizedBox(height: 20),
                          _DeviceFeatureList(),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: image),
                        const SizedBox(width: 24),
                        const Expanded(child: features),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 44,
                        color: Color(0xFF2457C5),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentName,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Группа: $studentGroup',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DeviceImage extends StatelessWidget {
  const _DeviceImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD5E0F5)),
      ),
      child: Image.asset(
        'assets/images/smartphone.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        semanticLabel: 'Смартфон',
      ),
    );
  }
}

class _DeviceFeatureList extends StatelessWidget {
  const _DeviceFeatureList();

  static const List<(IconData, String)> features = [
    (Icons.category_outlined, 'Категория: мобильная электроника'),
    (Icons.apps_outlined, 'Связь, приложения и мультимедиа'),
    (Icons.wifi, 'Wi-Fi, Bluetooth и мобильная сеть'),
    (Icons.battery_charging_full, 'Встроенный аккумулятор'),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Основные характеристики',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (final (IconData icon, String label) in features) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 22, color: primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16, height: 1.35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
        ],
      ],
    );
  }
}
