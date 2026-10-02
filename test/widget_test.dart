import 'package:cross_platform_frameworks/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('экран практической работы 2 содержит обязательные элементы', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(720, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.pump();

    expect(find.text('Электронные устройства'), findsOneWidget);
    expect(find.text('Смартфон'), findsOneWidget);
    expect(find.text('Основные характеристики'), findsOneWidget);
    expect(find.text('Ковалев М.М.'), findsOneWidget);
    expect(find.text('Группа: ИКБО-62-23'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
