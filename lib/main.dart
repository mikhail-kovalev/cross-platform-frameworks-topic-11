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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  border: const Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                child: const Text(
                  'ЭЛЕКТРОННЫЕ УСТРОЙСТВА',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DeviceDisplay',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _BorderedBox(
                        minHeight: 64,
                        child: Text(
                          device.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'DeviceDisplay',
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _BorderedBox(
                        minHeight: 92,
                        child: Text(
                          device.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16, height: 1.35),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 270,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                key: const Key('device-image'),
                                onTap: _showNextDevice,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Image.asset(
                                    device.imagePath,
                                    fit: BoxFit.contain,
                                    semanticLabel: device.name,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('1. ${device.category}'),
                                    const SizedBox(height: 8),
                                    Text('2. ${device.purpose}'),
                                    const SizedBox(height: 8),
                                    Text('3. ${device.interfaces}'),
                                    const SizedBox(height: 8),
                                    Text(
                                      '4. Устройство ${_currentIndex + 1} из ${devices.length}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          key: const Key('next-device-button'),
                          onPressed: _showNextDevice,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(),
                          ),
                          child: const Text('СЛЕДУЮЩЕЕ УСТРОЙСТВО'),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Icon(
                              Icons.person_outline,
                              size: 42,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _BorderedBox(
                              minHeight: 64,
                              child: const Text(
                                'Ковалев М.М.   ИКБО-62-23',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

class _BorderedBox extends StatelessWidget {
  const _BorderedBox({required this.minHeight, required this.child});

  final double minHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: child,
    );
  }
}
