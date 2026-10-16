import 'package:flutter/material.dart';

import '../models/local_account.dart';
import '../widgets/text_field.dart';
import 'profile_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.account});

  final LocalAccount account;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    if (!widget.account.signIn(_email.text, _password.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.account.registered
                ? 'Неверный email или пароль'
                : 'Сначала зарегистрируйтесь в приложении',
          ),
        ),
      );
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ProfilePage(account: widget.account),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 38),
                const Text(
                  'Добро пожаловать!\nВойдите в свой аккаунт\nИли создайте новый',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 38),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        inputType: InputFieldType.email,
                        controller: _email,
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        inputType: InputFieldType.password,
                        controller: _password,
                        labelText: 'Пароль',
                        textInputAction: TextInputAction.done,
                        onSubmitted: _submit,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text('Локальный аккаунт'),
                              content: const Text(
                                'Учётные данные хранятся только до закрытия приложения. Можно создать новый аккаунт на экране регистрации.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Понятно'),
                                ),
                              ],
                            ),
                          ),
                          child: const Text('Забыли пароль?'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: _submit,
                        child: const Text('Войти'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => RegisterPage(account: widget.account),
                    ),
                  ),
                  child: const Text('Нет аккаунта? Зарегистрируйтесь'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
