# Практическая работа №2

Тема предметной области: **№11 — «Кроссплатформенные фреймворки»**.

Приложение представляет Flutter и построено только на `StatelessWidget`. Экран
повторяет структуру примерного макета: заголовок, название и описание ПО,
изображение, четыре особенности и блок с данными студента.

## Персонализация

Перед сдачей замените значения `studentName` и `studentGroup` в
`lib/main.dart` на свои ФИО и номер группы.

## Запуск

```bash
flutter pub get
flutter run
```

## Проверка

```bash
flutter analyze
flutter test
```

В приложении использованы виджеты `Scaffold`, `AppBar`, `Column`, `Row`,
`Center`, `Divider`, `Container`, `SizedBox`, `Padding`, `Text`, `Image`,
`Icon`, `Expanded` и `SingleChildScrollView`.
