import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final dio = Dio();

  // Функція для відправки запиту на сервер
  void _validateAndLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Створення запиту для авторизації
        Response response = await dio.post(
          'https://laboratorna12.requestcatcher.com/', // URL вашого сервера
          data: {
            'email': _emailController.text,
            'password': _passwordController.text,
          },
        );
        print('Response: ${response.data}');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Авторизація')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Емейл'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть емейл';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Введіть правильний email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Пароль'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть пароль';
                  }
                  if (value.length < 7) {
                    return 'Пароль має бути не менше 7 символів';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _validateAndLogin,
                child: Text('Увійти'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('Реєстрація'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                  );
                },
                child: Text('Відновити пароль'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
