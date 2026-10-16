import 'package:flutter/material.dart';

import '../models/local_account.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.account});
  final LocalAccount account;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  final _password = TextEditingController();
  final _confirmation = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.account.name);
    _email = TextEditingController(text: widget.account.email);
  }

  @override
  void dispose() {
    for (final controller in [_name, _email, _password, _confirmation]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    widget.account.update(_name.text, _email.text, _password.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Профиль сохранён')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
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
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/camera.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
                        onSubmitted: _save,
                      ),
                      const SizedBox(height: 26),
                      FilledButton(
                        onPressed: _save,
                        child: const Text('Сохранить'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
