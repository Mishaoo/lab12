import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final dio = Dio();

  // Функція для відправки запиту на сервер
  void _validateAndResetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Створення запиту для відновлення паролю
        Response response = await dio.post(
          'https://laboratorna12.requestcatcher.com/', // URL вашого сервера
          data: {
            'email': _emailController.text,
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
      appBar: AppBar(title: Text('Відновлення паролю')),
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
                    return 'Введіть логін або email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Введіть правильний email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _validateAndResetPassword,
                child: Text('Відновити пароль'),
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
