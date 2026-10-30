import 'package:flutter/material.dart';

import '../models/device_item.dart';
import '../widgets/app_navigation_bar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.device});

  final DeviceItem device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  device.imagePath,
                  height: 220,
                  fit: BoxFit.contain,
                  semanticLabel: device.name,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                device.category,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                device.description,
                style: const TextStyle(fontSize: 17, height: 1.5),
              ),
              const SizedBox(height: 20),
              const Text(
                'Возможности устройства',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              for (var index = 0; index < device.features.length; index++)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '${index + 1}. ${device.features[index]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppNavigationBar(
        selectedIndex: 0,
        fromDetail: true,
      ),
    );
  }
}
