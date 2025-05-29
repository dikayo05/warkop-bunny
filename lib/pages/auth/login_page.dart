import 'package:flutter/material.dart';
import 'package:warkop_bunny/auth/auth_service.dart';
import 'package:warkop_bunny/components/my_button.dart';
import 'package:warkop_bunny/components/my_text_field.dart';
import 'package:warkop_bunny/pages/auth/register_page.dart';
import 'package:warkop_bunny/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // get auth service
  final AuthService authService = AuthService();

  // text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  // login button pressed
  Future<void> login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // attempt login..
    try {
      // ensure that the email & password fields are not empty
      if (email.isNotEmpty && password.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });
        // login logic
        await authService.signInWithEmailPassword(email, password);

          // navigate to MainPage and remove all previous pages
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false,
          );
        }
      } else {
        // display error if some fields are empty
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter both email and password")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // dispose of the text controllers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      // BODY
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login'),

                // logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 50),

                // welcome back message
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email text field
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password text field
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // login button
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  MyButton(onTap: login, text: "Login"),

                const SizedBox(height: 50),

                // not a member? register now button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have any account? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      ),
                      child: Text(
                        "Register here",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
