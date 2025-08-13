import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vio_film/provider/share.dart';
import 'package:vio_film/provider/theme_provider.dart';
import 'package:vio_film/view/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ShareProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(title: 'Vio Film'),
    );
  }
}
