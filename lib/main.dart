import 'package:flutter/material.dart';
import 'package:ordn/router/router.dart';
import 'package:ordn/viewmodels/item_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemViewmodel(),
      child: const MyApp(),
    ),
  );
}

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
