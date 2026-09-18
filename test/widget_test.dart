import 'package:cross_platform_frameworks/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('экран содержит обязательные элементы макета', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(720, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CrossPlatformFrameworksApp());
    await tester.pump();

    expect(find.text('Кроссплатформенные фреймворки'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Основные особенности'), findsOneWidget);
    expect(find.text('Ковалев М.М.'), findsOneWidget);
    expect(find.text('Группа: ИКБО-62-23'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
