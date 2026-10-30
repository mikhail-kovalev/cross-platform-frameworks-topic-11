import 'package:cross_platform_frameworks/main.dart';
import 'package:cross_platform_frameworks/models/device_item.dart';
import 'package:cross_platform_frameworks/models/local_account.dart';
import 'package:cross_platform_frameworks/pages/home_page.dart';
import 'package:cross_platform_frameworks/pages/loading_page.dart';
import 'package:cross_platform_frameworks/pages/login_page.dart';
import 'package:cross_platform_frameworks/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void setScreen(WidgetTester tester, double width) {
  tester.view.physicalSize = Size(width, 1100);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> signIn(WidgetTester tester) async {
  final account = LocalAccount()
    ..register('Михаил Ковалев', 'student@example.ru', 'Device1+');
  await tester.pumpWidget(ElectronicDevicesApp(account: account));
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
  await tester.enterText(
    find.byType(TextFormField).at(0),
    'student@example.ru',
  );
  await tester.enterText(find.byType(TextFormField).at(1), 'Device1+');
  await tester.tap(find.text('Войти'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('заставка заменяется входом ровно через четыре секунды', (
    tester,
  ) async {
    await tester.pumpWidget(const ElectronicDevicesApp());
    expect(find.byType(LoadingPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 3999));
    expect(find.byType(LoginPage), findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(LoginPage))).canPop(),
      isFalse,
    );
  });

  testWidgets('таймер заставки отменяется при удалении страницы', (
    tester,
  ) async {
    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('авторизация открывает каталог без возврата к форме входа', (
    tester,
  ) async {
    setScreen(tester, 430);
    await signIn(tester);
    expect(find.byType(HomePage), findsOneWidget);
    expect(
      ModalRoute.of(tester.element(find.byType(HomePage)))!.settings.name,
      Routes.home,
    );
    expect(
      Navigator.of(tester.element(find.byType(HomePage))).canPop(),
      isFalse,
    );
    expect(find.byKey(const Key('device-column')), findsOneWidget);
    expect(
      tester
          .widget<ListView>(find.byKey(const Key('horizontal-image-list')))
          .scrollDirection,
      Axis.horizontal,
    );
    expect(DeviceItem.devices.length, 5);
  });

  testWidgets('карточка передаёт выбранное устройство на экран деталей', (
    tester,
  ) async {
    setScreen(tester, 430);
    await signIn(tester);
    await tester.tap(find.byKey(const ValueKey('device-card-1')));
    await tester.pumpAndSettle();
    expect(find.text('Ноутбук'), findsOneWidget);
    expect(find.text('Работа от аккумулятора'), findsNothing);
    expect(find.text('2. Работа от аккумулятора'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets(
    'нижняя панель переключает главную и профиль без накопления маршрутов',
    (tester) async {
      setScreen(tester, 430);
      await signIn(tester);
      await tester.tap(find.text('Профиль'));
      await tester.pumpAndSettle();
      expect(find.text('Сохранить'), findsOneWidget);
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
        1,
      );
      expect(
        tester
            .widget<TextFormField>(find.byType(TextFormField).at(0))
            .controller!
            .text,
        'Михаил Ковалев',
      );
      await tester.tap(find.text('Главная'));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      expect(
        Navigator.of(tester.element(find.byType(HomePage))).canPop(),
        isFalse,
      );
      await tester.tap(find.byKey(const ValueKey('device-card-0')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Профиль'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Главная'));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
      expect(
        Navigator.of(tester.element(find.byType(HomePage))).canPop(),
        isFalse,
      );
    },
  );

  for (final width in [600.0, 601.0, 1200.0]) {
    testWidgets('адаптивная компоновка при ширине $width', (tester) async {
      setScreen(tester, width);
      await tester.pumpWidget(const MaterialApp(home: HomePage()));
      await tester.pumpAndSettle();
      if (width > 600) {
        final grid = tester.widget<GridView>(
          find.byKey(const Key('device-grid')),
        );
        expect(
          (grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
              .crossAxisCount,
          2,
        );
        expect(
          tester.getTopLeft(find.byKey(const ValueKey('device-card-0'))).dy,
          tester.getTopLeft(find.byKey(const ValueKey('device-card-1'))).dy,
        );
      } else {
        expect(find.byType(GridView), findsNothing);
        expect(find.byKey(const Key('device-column')), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('на desktop увеличены вертикальные интервалы', (tester) async {
    setScreen(tester, 900);
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    for (final platform in [TargetPlatform.android, TargetPlatform.windows]) {
      debugDefaultTargetPlatformOverride = platform;
      await tester.pumpWidget(
        MaterialApp(key: ValueKey(platform), home: const HomePage()),
      );
      await tester.pumpAndSettle();
      final grid = tester.widget<GridView>(
        find.byKey(const Key('device-grid')),
      );
      expect(
        (grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount)
            .mainAxisSpacing,
        platform == TargetPlatform.windows ? 24 : 12,
      );
    }
    debugDefaultTargetPlatformOverride = null;
  });
}
