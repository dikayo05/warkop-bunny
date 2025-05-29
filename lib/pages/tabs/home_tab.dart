import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to the Home Tab!"),
            ElevatedButton(
              onPressed: () {
                // Action when button is pressed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Button Pressed!")),
                );
              },
              child: const Text("Press Me"),
            ),
          ],
        ),
      ),
    );
  }
}
