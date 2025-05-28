import 'package:flutter/material.dart';
import 'package:warkop_bunny/pages/home_page.dart';
import 'package:warkop_bunny/themes/light_mode.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wxwprcxzityepfhmlpsg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind4d3ByY3h6aXR5ZXBmaG1scHNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg0NDUzMDUsImV4cCI6MjA2NDAyMTMwNX0.LRady5Mgs-FZjOGD9fELjkMnnVbZislscD2reWi3A5c',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightMode,
      home: HomePage(),
    );
  }
}
