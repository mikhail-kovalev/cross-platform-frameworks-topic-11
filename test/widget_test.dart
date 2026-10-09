import 'package:cross_platform_frameworks/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('экран содержит горизонтальный и вертикальный списки', (
    tester,
  ) async {
    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.pumpAndSettle();

    expect(find.text('ЭЛЕКТРОННЫЕ УСТРОЙСТВА'), findsOneWidget);
    expect(find.text('Каталог электронных устройств'), findsOneWidget);

    final horizontal = tester.widget<ListView>(
      find.byKey(const Key('horizontal-image-list')),
    );
    final vertical = tester.widget<ListView>(
      find.byKey(const Key('vertical-device-list')),
    );

    expect(horizontal.scrollDirection, Axis.horizontal);
    expect(vertical.scrollDirection, Axis.vertical);
    expect(ElectronicDevicesPage.devices.length, 5);
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets('нажатие на карточку показывает SnackBar', (tester) async {
    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('device-card-0')));
    await tester.pump();

    expect(find.text('Выбрано устройство: Смартфон'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('внизу списка отображаются данные студента', (tester) async {
    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const Key('vertical-device-list')),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();

    expect(find.text('Ковалев М.М.   ИКБО-62-23'), findsOneWidget);
  });
}
