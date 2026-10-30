import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/device_item.dart';
import '../routes.dart';
import '../widgets/app_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static bool get desktopOrWeb =>
      kIsWeb ||
      {
        TargetPlatform.windows,
        TargetPlatform.macOS,
        TargetPlatform.linux,
      }.contains(defaultTargetPlatform);

  Widget _deviceCard(BuildContext context, int index) {
    final device = DeviceItem.devices[index];
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: ListTile(
        key: ValueKey('device-card-$index'),
        leading: Icon(device.icon, color: Colors.blue.shade700),
        title: Text(device.name),
        subtitle: Text('${device.category}. ${device.description}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () =>
            Navigator.pushNamed(context, Routes.detail, arguments: device),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = desktopOrWeb ? 24.0 : 12.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ЭЛЕКТРОННЫЕ УСТРОЙСТВА',
          style: TextStyle(fontFamily: 'DeviceDisplay', fontSize: 18),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 600;
          return ListView(
            key: const Key('vertical-device-list'),
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 32 : 16,
              vertical: gap,
            ),
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
              SizedBox(height: gap),
              const Text(
                'Выберите устройство, чтобы узнать о нём подробнее.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.35),
              ),
              SizedBox(height: gap),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  key: const Key('horizontal-image-list'),
                  scrollDirection: Axis.horizontal,
                  itemCount: DeviceItem.devices.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final device = DeviceItem.devices[index];
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
              SizedBox(height: gap),
              const Text(
                'Список устройств',
                style: TextStyle(
                  fontFamily: 'DeviceDisplay',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: gap),
              if (wide)
                GridView.builder(
                  key: const Key('device-grid'),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DeviceItem.devices.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: gap,
                    crossAxisSpacing: 16,
                    mainAxisExtent:
                        160 * MediaQuery.textScalerOf(context).scale(1),
                  ),
                  itemBuilder: _deviceCard,
                )
              else
                Column(
                  key: const Key('device-column'),
                  children: [
                    for (
                      var index = 0;
                      index < DeviceItem.devices.length;
                      index++
                    ) ...[
                      _deviceCard(context, index),
                      if (index < DeviceItem.devices.length - 1)
                        SizedBox(height: gap),
                    ],
                  ],
                ),
              SizedBox(height: gap),
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
                    Flexible(
                      child: Text(
                        'Ковалев М.М.   ИКБО-62-23',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const AppNavigationBar(selectedIndex: 0),
    );
  }
}
