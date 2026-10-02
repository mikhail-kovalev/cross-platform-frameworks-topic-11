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

class ElectronicDevicesPage extends StatefulWidget {
  const ElectronicDevicesPage({super.key});

  @override
  State<ElectronicDevicesPage> createState() => _ElectronicDevicesPageState();
}

class _ElectronicDevicesPageState extends State<ElectronicDevicesPage> {
  static const String studentName = 'Ковалев М.М.';
  static const String studentGroup = 'ИКБО-62-23';

  static const List<DeviceItem> devices = [
    DeviceItem(
      name: 'Смартфон',
      category: 'Мобильная электроника',
      purpose: 'Связь, навигация и приложения',
      interfaces: 'Сотовая сеть, Wi-Fi и Bluetooth',
      description: 'Смартфон объединяет средства связи, камеру, навигацию и доступ к цифровым сервисам.',
      imagePath: 'assets/images/smartphone.png',
      icon: Icons.smartphone,
    ),
    DeviceItem(
      name: 'Ноутбук',
      category: 'Компьютерная техника',
      purpose: 'Работа, обучение и творчество',
      interfaces: 'Wi-Fi, Bluetooth и USB',
      description: 'Ноутбук сочетает производительность персонального компьютера и мобильность.',
      imagePath: 'assets/images/laptop.png',
      icon: Icons.laptop_mac,
    ),
    DeviceItem(
      name: 'Цифровая камера',
      category: 'Фото- и видеотехника',
      purpose: 'Фото- и видеосъёмка',
      interfaces: 'Wi-Fi, Bluetooth и USB-C',
      description:
          'Цифровая камера сохраняет фотографии и видео в электронном формате.',
      imagePath: 'assets/images/camera.png',
      icon: Icons.photo_camera_outlined,
    ),
    DeviceItem(
      name: 'Беспроводные наушники',
      category: 'Аудиотехника',
      purpose: 'Прослушивание музыки и связь',
      interfaces: 'Bluetooth и USB-C',
      description: 'Беспроводные наушники воспроизводят звук и позволяют общаться без кабеля.',
      imagePath: 'assets/images/headphones.png',
      icon: Icons.headphones,
    ),
    DeviceItem(
      name: 'Умные часы',
      category: 'Носимая электроника',
      purpose: 'Уведомления и контроль активности',
      interfaces: 'Bluetooth, NFC и Wi-Fi',
      description: 'Умные часы отображают уведомления и помогают отслеживать физическую активность.',
      imagePath: 'assets/images/smartwatch.png',
      icon: Icons.watch_outlined,
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
    final ColorScheme colors = Theme.of(context).colorScheme;
    final DeviceItem device = devices[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        centerTitle: true,
        title: const Text(
          'Электронные устройства',
          style: TextStyle(
            fontFamily: 'DeviceDisplay',
            fontWeight: FontWeight.w700,
          ),
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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    key: ValueKey<String>(device.name),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(device.icon, size: 30, color: colors.primary),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            device.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'DeviceDisplay',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    device.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, height: 1.4),
                  ),
                ),
                const SizedBox(height: 18),
                const Divider(),
                const SizedBox(height: 18),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final bool isCompact = constraints.maxWidth < 520;
                    final Widget image = _DeviceImage(
                      device: device,
                      onTap: _showNextDevice,
                    );
                    final Widget details = _DeviceDetails(device: device);

                    if (isCompact) {
                      return Column(
                        children: [image, const SizedBox(height: 18), details],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: image),
                        const SizedBox(width: 24),
                        Expanded(child: details),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 18),
                Text(
                  'Нажмите на изображение или кнопку, чтобы перейти к следующему устройству.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colors.onSurfaceVariant, height: 1.3),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  key: const Key('next-device-button'),
                  onPressed: _showNextDevice,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('Следующее устройство'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(
                      fontFamily: 'DeviceDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int index = 0; index < devices.length; index++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: index == _currentIndex ? 22 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: index == _currentIndex
                              ? colors.primary
                              : colors.outlineVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    const SizedBox(width: 10),
                    Text('${_currentIndex + 1} из ${devices.length}'),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4FC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 42,
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

class DeviceItem {
  const DeviceItem({
    required this.name,
    required this.category,
    required this.purpose,
    required this.interfaces,
    required this.description,
    required this.imagePath,
    required this.icon,
  });

  final String name;
  final String category;
  final String purpose;
  final String interfaces;
  final String description;
  final String imagePath;
  final IconData icon;
}

class _DeviceImage extends StatelessWidget {
  const _DeviceImage({required this.device, required this.onTap});

  final DeviceItem device;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Показать следующее устройство',
      child: GestureDetector(
        key: const Key('device-image'),
        onTap: onTap,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Container(
            key: ValueKey<String>(device.imagePath),
            height: 230,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F8FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD5E0F5)),
            ),
            child: Image.asset(
              device.imagePath,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              semanticLabel: device.name,
            ),
          ),
        ),
      ),
    );
  }
}

class _DeviceDetails extends StatelessWidget {
  const _DeviceDetails({required this.device});

  final DeviceItem device;

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final List<(IconData, String)> details = [
      (Icons.category_outlined, device.category),
      (Icons.task_alt, device.purpose),
      (Icons.settings_input_antenna, device.interfaces),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Характеристики',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (final (IconData icon, String label) in details) ...[
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
