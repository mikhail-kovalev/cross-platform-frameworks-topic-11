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
        useMaterial3: true,
      ),
      home: const ElectronicDevicesPage(),
    );
  }
}

class ElectronicDevicesPage extends StatefulWidget {
  const ElectronicDevicesPage({super.key});

  @override
  State<ElectronicDevicesPage> createState() => _ElectronicDevicesPageState();
}

class _ElectronicDevicesPageState extends State<ElectronicDevicesPage> {
  static const List<DeviceItem> devices = [
    DeviceItem(
      name: 'Смартфон',
      category: 'Мобильная электроника',
      purpose: 'Связь, навигация и приложения',
      interfaces: 'Сотовая сеть, Wi-Fi и Bluetooth',
      description: 'Смартфон объединяет средства связи, камеру, навигацию и доступ к цифровым сервисам.',
      imagePath: 'assets/images/smartphone.png',
    ),
    DeviceItem(
      name: 'Ноутбук',
      category: 'Компьютерная техника',
      purpose: 'Работа, обучение и творчество',
      interfaces: 'Wi-Fi, Bluetooth и USB',
      description: 'Ноутбук сочетает производительность персонального компьютера и мобильность.',
      imagePath: 'assets/images/laptop.png',
    ),
    DeviceItem(
      name: 'Цифровая камера',
      category: 'Фото- и видеотехника',
      purpose: 'Фото- и видеосъёмка',
      interfaces: 'Wi-Fi, Bluetooth и USB-C',
      description:
          'Цифровая камера сохраняет фотографии и видео в электронном формате.',
      imagePath: 'assets/images/camera.png',
    ),
    DeviceItem(
      name: 'Беспроводные наушники',
      category: 'Аудиотехника',
      purpose: 'Прослушивание музыки и связь',
      interfaces: 'Bluetooth и USB-C',
      description: 'Беспроводные наушники воспроизводят звук и позволяют общаться без кабеля.',
      imagePath: 'assets/images/headphones.png',
    ),
    DeviceItem(
      name: 'Умные часы',
      category: 'Носимая электроника',
      purpose: 'Уведомления и контроль активности',
      interfaces: 'Bluetooth, NFC и Wi-Fi',
      description: 'Умные часы отображают уведомления и помогают отслеживать физическую активность.',
      imagePath: 'assets/images/smartwatch.png',
    ),
  ];

  int _currentIndex = 0;

  void _showNextDevice() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % devices.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DeviceItem device = devices[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: const Text(
          'Электронные устройства',
          style: TextStyle(fontFamily: 'DeviceDisplay'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              device.name,
              style: const TextStyle(
                fontFamily: 'DeviceDisplay',
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(device.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            InkWell(
              key: const Key('device-image'),
              onTap: _showNextDevice,
              child: Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Image.asset(
                  device.imagePath,
                  fit: BoxFit.contain,
                  semanticLabel: device.name,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Нажмите на изображение, чтобы показать следующее устройство',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const Text(
              'Характеристики',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _PropertyRow(
              icon: Icons.category_outlined,
              label: 'Категория',
              value: device.category,
            ),
            _PropertyRow(
              icon: Icons.task_alt,
              label: 'Назначение',
              value: device.purpose,
            ),
            _PropertyRow(
              icon: Icons.settings_input_antenna,
              label: 'Интерфейсы',
              value: device.interfaces,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                key: const Key('next-device-button'),
                onPressed: _showNextDevice,
                child: const Text('Следующее устройство'),
              ),
            ),
            const SizedBox(height: 8),
            Center(child: Text('Устройство ${_currentIndex + 1} из 5')),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Выполнил: Ковалев М.М.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('Группа: ИКБО-62-23'),
          ],
        ),
      ),
    );
  }
}

class DeviceItem {
  const DeviceItem({
    required this.name,
    required this.category,
    required this.purpose,
    required this.interfaces,
    required this.description,
    required this.imagePath,
  });

  final String name;
  final String category;
  final String purpose;
  final String interfaces;
  final String description;
  final String imagePath;
}

class _PropertyRow extends StatelessWidget {
  const _PropertyRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
