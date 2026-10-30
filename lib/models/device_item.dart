import 'package:flutter/material.dart';

class DeviceItem {
  const DeviceItem({
    required this.name,
    required this.category,
    required this.description,
    required this.imagePath,
    required this.icon,
    required this.features,
  });

  final String name;
  final String category;
  final String description;
  final String imagePath;
  final IconData icon;
  final List<String> features;

  static const devices = [
    DeviceItem(
      name: 'Смартфон',
      category: 'Мобильная электроника',
      description: 'Средство связи, навигации и работы с приложениями.',
      imagePath: 'assets/images/smartphone.png',
      icon: Icons.smartphone,
      features: [
        'Сенсорный экран',
        'Камера для фото и видео',
        'Мобильная связь и Wi-Fi',
        'GPS-навигация',
      ],
    ),
    DeviceItem(
      name: 'Ноутбук',
      category: 'Компьютерная техника',
      description: 'Переносной компьютер для работы, учёбы и творчества.',
      imagePath: 'assets/images/laptop.png',
      icon: Icons.laptop_mac,
      features: [
        'Экран и клавиатура в одном корпусе',
        'Работа от аккумулятора',
        'Подключение внешних устройств',
        'Запуск настольных приложений',
      ],
    ),
    DeviceItem(
      name: 'Цифровая камера',
      category: 'Фото- и видеотехника',
      description: 'Устройство для создания фотографий и видеозаписей.',
      imagePath: 'assets/images/camera.png',
      icon: Icons.photo_camera_outlined,
      features: [
        'Объектив и цифровая матрица',
        'Сохранение снимков на карту памяти',
        'Настройка параметров съёмки',
        'Запись видео',
      ],
    ),
    DeviceItem(
      name: 'Беспроводные наушники',
      category: 'Аудиотехника',
      description: 'Устройство для прослушивания звука без проводов.',
      imagePath: 'assets/images/headphones.png',
      icon: Icons.headphones,
      features: [
        'Подключение по Bluetooth',
        'Встроенный аккумулятор',
        'Микрофон для разговоров',
        'Управление воспроизведением',
      ],
    ),
    DeviceItem(
      name: 'Умные часы',
      category: 'Носимая электроника',
      description: 'Устройство для уведомлений и контроля активности.',
      imagePath: 'assets/images/smartwatch.png',
      icon: Icons.watch_outlined,
      features: [
        'Уведомления со смартфона',
        'Подсчёт шагов',
        'Отслеживание тренировок',
        'Отображение времени и даты',
      ],
    ),
  ];
}
