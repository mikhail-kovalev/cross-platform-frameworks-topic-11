import 'package:cross_platform_frameworks/main.dart';
import 'package:cross_platform_frameworks/models/local_account.dart';
import 'package:cross_platform_frameworks/pages/login_page.dart';
import 'package:cross_platform_frameworks/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('валидация полей', () {
    test('пустые значения отклоняются', () {
      for (final type in InputFieldType.values) {
        for (final value in [null, '', '   ']) {
          expect(CustomTextFormField.validate(type, value), isNotNull);
        }
      }
    });

    test('имя содержит только буквы и пробелы', () {
      expect(
        CustomTextFormField.validate(InputFieldType.name, 'Ковалев Михаил'),
        isNull,
      );
      expect(CustomTextFormField.validate(InputFieldType.name, 'Пётр'), isNull);
      expect(
        CustomTextFormField.validate(InputFieldType.name, 'Иван123'),
        isNotNull,
      );
    });

    test('email содержит адрес и домен с точкой', () {
      for (final value in ['name@example.ru', 'student@sub.example.ru']) {
        expect(
          CustomTextFormField.validate(InputFieldType.email, value),
          isNull,
        );
      }
      for (final value in [
        'name',
        '@example.ru',
        'name@',
        'name@example',
        'a@@b.ru',
        'a@b..ru',
      ]) {
        expect(
          CustomTextFormField.validate(InputFieldType.email, value),
          isNotNull,
        );
      }
    });

    test('пароль содержит букву цифру и разрешённый спецсимвол', () {
      for (final value in ['Abc12+', 'Abc12_', 'Abc12-']) {
        expect(
          CustomTextFormField.validate(InputFieldType.password, value),
          isNull,
        );
      }
      for (final value in [
        'Ab1+',
        'abcdef',
        '123456',
        'Abc123',
        'Abcde+',
        '12345_',
        'Abc 12+',
      ]) {
        expect(
          CustomTextFormField.validate(InputFieldType.password, value),
          isNotNull,
        );
      }
    });

    test('повтор должен совпадать с паролем', () {
      expect(
        CustomTextFormField.validate(
          InputFieldType.confirmPassword,
          'Abc12+',
          password: 'Abc12+',
        ),
        isNull,
      );
      expect(
        CustomTextFormField.validate(
          InputFieldType.confirmPassword,
          'Abc12-',
          password: 'Abc12+',
        ),
        isNotNull,
      );
    });
  });

  testWidgets('регистрация отклоняет ошибки и сохраняет корректные данные', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.tap(find.byTooltip('Личный кабинет'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Нет аккаунта? Зарегистрируйтесь'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Зарегистрироваться'));
    await tester.pumpAndSettle();
    expect(find.text('Заполните поле'), findsNWidgets(4));

    var fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Ковалев Михаил');
    await tester.enterText(fields.at(1), 'student@example.ru');
    await tester.enterText(fields.at(2), 'Device1+');
    await tester.enterText(fields.at(3), 'Device1-');
    await tester.tap(find.text('Зарегистрироваться'));
    await tester.pumpAndSettle();
    expect(find.text('Пароли не совпадают'), findsOneWidget);
    await tester.enterText(fields.at(3), 'Device1+');
    await tester.tap(find.text('Зарегистрироваться'));
    await tester.pumpAndSettle();
    expect(find.text('Профиль'), findsOneWidget);
    fields = find.byType(TextFormField);
    expect(
      tester.widget<TextFormField>(fields.at(0)).controller!.text,
      'Ковалев Михаил',
    );
    expect(
      tester.widget<TextFormField>(fields.at(1)).controller!.text,
      'student@example.ru',
    );

    await tester.enterText(fields.at(0), 'Михаил Ковалев');
    await tester.enterText(fields.at(2), 'Device2_');
    await tester.enterText(fields.at(3), 'Device2_');
    await tester.tap(find.text('Сохранить'));
    await tester.pump();
    expect(find.text('Профиль сохранён'), findsOneWidget);
  });

  testWidgets('вход проверяет зарегистрированные данные', (tester) async {
    final account = LocalAccount()
      ..register('Михаил', 'student@example.ru', 'Device1+');
    await tester.pumpWidget(MaterialApp(home: LoginPage(account: account)));
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'student@example.ru');
    await tester.enterText(fields.at(1), 'Wrong1+');
    await tester.tap(find.text('Войти'));
    await tester.pump();
    expect(find.text('Неверный email или пароль'), findsOneWidget);
    await tester.enterText(fields.at(1), 'Device1+');
    await tester.tap(find.text('Войти'));
    await tester.pumpAndSettle();
    expect(find.text('Профиль'), findsOneWidget);
  });

  testWidgets('Next переводит фокус и глаз показывает пароль', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginPage(account: LocalAccount())),
    );
    final fields = find.byType(TextFormField);
    await tester.tap(fields.at(0));
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pump();
    final passwordEditable = tester.widget<EditableText>(
      find.descendant(of: fields.at(1), matching: find.byType(EditableText)),
    );
    expect(passwordEditable.focusNode.hasFocus, isTrue);
    expect(passwordEditable.obscureText, isTrue);
    await tester.tap(find.byTooltip('Показать пароль'));
    await tester.pump();
    expect(
      tester
          .widget<EditableText>(
            find.descendant(
              of: fields.at(1),
              matching: find.byType(EditableText),
            ),
          )
          .obscureText,
      isFalse,
    );
  });

  test('после изменения профиля действуют новые учётные данные', () {
    final account = LocalAccount()
      ..register('Иван', 'old@example.ru', 'Device1+');
    account.update('Пётр', 'new@example.ru', 'Device2_');
    expect(account.signIn('old@example.ru', 'Device1+'), isFalse);
    expect(account.signIn('NEW@example.ru', 'Device2_'), isTrue);
  });

  testWidgets('фокус последовательно проходит все поля регистрации', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 820);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const ElectronicDevicesApp());
    await tester.tap(find.byTooltip('Личный кабинет'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Нет аккаунта? Зарегистрируйтесь'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Нет аккаунта? Зарегистрируйтесь'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.tap(fields.at(0));
    for (var index = 1; index < 4; index++) {
      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pump();
      final editable = tester.widget<EditableText>(
        find.descendant(
          of: fields.at(index),
          matching: find.byType(EditableText),
        ),
      );
      expect(editable.focusNode.hasFocus, isTrue);
    }
  });
}
