import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final dio = Dio();

  // Функція для відправки запиту на сервер
  void _validateAndRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Створення запиту для реєстрації
        Response response = await dio.post(
          'https://laboratorna12.requestcatcher.com/', // URL вашого сервера
          data: {
            'username': _usernameController.text,
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
      appBar: AppBar(title: Text('Реєстрація')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Ім\'я користувача'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Це поле не може бути порожнім';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
                onPressed: _validateAndRegister,
                child: Text('Зареєструватися'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Повернутися до авторизації'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
