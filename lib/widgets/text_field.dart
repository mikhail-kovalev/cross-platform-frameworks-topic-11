import 'package:flutter/material.dart';

enum InputFieldType { name, email, password, confirmPassword }

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.controller,
    required this.labelText,
    this.passwordController,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
  });

  final InputFieldType inputType;
  final TextEditingController controller;
  final String labelText;
  final TextEditingController? passwordController;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;

  static String? validate(
    InputFieldType type,
    String? value, {
    String? password,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Заполните поле';
    }
    switch (type) {
      case InputFieldType.name:
        if (!RegExp(r'^[A-Za-zА-Яа-яЁё ]+$').hasMatch(value.trim())) {
          return 'В имени допустимы только буквы и пробелы';
        }
      case InputFieldType.email:
        if (!RegExp(r'^[^\s@]+@[^\s@.]+(?:\.[^\s@.]+)+$')
            .hasMatch(value.trim())) {
          return 'Введите email в формате name@example.ru';
        }
      case InputFieldType.password:
        if (!RegExp(r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*[0-9])(?=.*[+_-])\S{6,}$')
            .hasMatch(value)) {
          return 'Не менее 6 символов: буквы, цифры и +, _ или -';
        }
      case InputFieldType.confirmPassword:
        if (value != password) return 'Пароли не совпадают';
    }
    return null;
  }

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final isPassword =
        widget.inputType == InputFieldType.password ||
        widget.inputType == InputFieldType.confirmPassword;
    final icon = switch (widget.inputType) {
      InputFieldType.name => Icons.person_outline,
      InputFieldType.email => Icons.mail_outline,
      _ => Icons.shield_outlined,
    };
    return TextFormField(
      controller: widget.controller,
      obscureText: isPassword && _hidePassword,
      autocorrect: !isPassword,
      enableSuggestions: !isPassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.textInputAction,
      onEditingComplete: () {},
      onFieldSubmitted: (_) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: isPassword
            ? ExcludeFocus(
                child: IconButton(
                  tooltip: _hidePassword ? 'Показать пароль' : 'Скрыть пароль',
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                  icon: Icon(
                    _hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              )
            : null,
        filled: false,
        errorMaxLines: 2,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      validator: (value) => CustomTextFormField.validate(
        widget.inputType,
        value,
        password: widget.passwordController?.text,
      ),
    );
  }
}
