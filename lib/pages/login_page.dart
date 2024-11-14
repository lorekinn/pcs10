import 'package:app1/main.dart';
import 'package:app1/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:app1/components/auth_service.dart';
import 'register_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    }

    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Авторизация")),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Почта"),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Пароль"),
            obscureText: true,
          ),

          const SizedBox(height: 12),

          ElevatedButton(
              onPressed: login,
              child: const Text("Войти"),
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterPage()
              )
            ),
              child: const Center(child: Text("Нет аккаунта? Зарегистрируйтесь")
              ),
          ),

        ],
      )
    );
  }
}