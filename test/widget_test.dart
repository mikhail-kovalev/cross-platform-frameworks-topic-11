import 'package:cross_platform_frameworks/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(720, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.pumpAndSettle();
  }

  testWidgets('экран содержит ресурсы и данные студента', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('ЭЛЕКТРОННЫЕ УСТРОЙСТВА'), findsOneWidget);
    expect(find.text('Смартфон'), findsOneWidget);
    expect(find.textContaining('Устройство 1 из 5'), findsOneWidget);
    expect(find.text('Ковалев М.М.   ИКБО-62-23'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('кнопка циклически переключает устройства', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('next-device-button')));
    await tester.pumpAndSettle();

    expect(find.text('Ноутбук'), findsOneWidget);
    expect(find.textContaining('Устройство 2 из 5'), findsOneWidget);
  });

  testWidgets('нажатие на изображение переключает устройство', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('device-image')));
    await tester.pumpAndSettle();

    expect(find.text('Ноутбук'), findsOneWidget);
    expect(find.textContaining('Устройство 2 из 5'), findsOneWidget);
  });
}
