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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ElectronicDevicesPage(),
    );
  }
}

class ElectronicDevicesPage extends StatelessWidget {
  const ElectronicDevicesPage({super.key});

  static const List<DeviceItem> devices = [
    DeviceItem(
      name: 'Смартфон',
      category: 'Мобильная электроника',
      description: 'Средство связи, навигации и работы с приложениями.',
      imagePath: 'assets/images/smartphone.png',
      icon: Icons.smartphone,
    ),
    DeviceItem(
      name: 'Ноутбук',
      category: 'Компьютерная техника',
      description: 'Переносной компьютер для работы, учёбы и творчества.',
      imagePath: 'assets/images/laptop.png',
      icon: Icons.laptop_mac,
    ),
    DeviceItem(
      name: 'Цифровая камера',
      category: 'Фото- и видеотехника',
      description: 'Устройство для создания фотографий и видеозаписей.',
      imagePath: 'assets/images/camera.png',
      icon: Icons.photo_camera_outlined,
    ),
    DeviceItem(
      name: 'Беспроводные наушники',
      category: 'Аудиотехника',
      description: 'Устройство для прослушивания звука без проводов.',
      imagePath: 'assets/images/headphones.png',
      icon: Icons.headphones,
    ),
    DeviceItem(
      name: 'Умные часы',
      category: 'Носимая электроника',
      description: 'Устройство для уведомлений и контроля активности.',
      imagePath: 'assets/images/smartwatch.png',
      icon: Icons.watch_outlined,
    ),
  ];

  void _showDeviceMessage(BuildContext context, DeviceItem device) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('Выбрано устройство: ${device.name}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'ЭЛЕКТРОННЫЕ УСТРОЙСТВА',
          style: TextStyle(fontFamily: 'DeviceDisplay'),
        ),
      ),
      body: ListView(
        key: const Key('vertical-device-list'),
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Каталог электронных устройств',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'DeviceDisplay',
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Выберите устройство в списке, чтобы увидеть короткое уведомление с его названием.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.35),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 190,
            child: ListView.separated(
              key: const Key('horizontal-image-list'),
              scrollDirection: Axis.horizontal,
              itemCount: devices.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final device = devices[index];
                return SizedBox(
                  width: 230,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      device.imagePath,
                      fit: BoxFit.cover,
                      semanticLabel: device.name,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Список устройств',
            style: TextStyle(
              fontFamily: 'DeviceDisplay',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          for (var index = 0; index < devices.length; index++) ...[
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                key: ValueKey('device-card-$index'),
                leading: Icon(devices[index].icon, color: Colors.blue.shade700),
                title: Text(devices[index].name),
                subtitle: Text(
                  '${devices[index].category}. ${devices[index].description}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => _showDeviceMessage(context, devices[index]),
              ),
            ),
            if (index < devices.length - 1) const SizedBox(height: 6),
          ],
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, size: 34),
                SizedBox(width: 12),
                Text(
                  'Ковалев М.М.   ИКБО-62-23',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceItem {
  const DeviceItem({
    required this.name,
    required this.category,
    required this.description,
    required this.imagePath,
    required this.icon,
  });

  final String name;
  final String category;
  final String description;
  final String imagePath;
  final IconData icon;
}
