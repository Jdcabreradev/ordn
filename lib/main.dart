import 'package:flutter/material.dart';
import 'package:ordn/router/router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Ordn App",
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
