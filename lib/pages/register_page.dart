import 'package:flutter/material.dart';

import '../models/local_account.dart';
import '../widgets/text_field.dart';
import 'login_page.dart';
import 'profile_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.account});
  final LocalAccount account;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  @override
  void dispose() {
    for (final controller in [_name, _email, _password, _confirmation]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    widget.account.register(_name.text, _email.text, _password.text);
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
                const SizedBox(height: 30),
                const Text(
                  'Регистрация',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        inputType: InputFieldType.name,
                        controller: _name,
                        labelText: 'ФИО',
                      ),
                      const SizedBox(height: 16),
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
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        inputType: InputFieldType.confirmPassword,
                        controller: _confirmation,
                        passwordController: _password,
                        labelText: 'Повторите пароль',
                        textInputAction: TextInputAction.done,
                        onSubmitted: _submit,
                      ),
                      const SizedBox(height: 26),
                      FilledButton(
                        onPressed: _submit,
                        child: const Text('Зарегистрироваться'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => LoginPage(account: widget.account),
                    ),
                  ),
                  child: const Text('Уже есть аккаунт? Войдите'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
