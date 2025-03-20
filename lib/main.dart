import 'package:flutter/material.dart';
import 'package:transit_app/routes.dart';

void main() => runApp(const MyApp());

final ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.green.shade600,
  secondary: Color.fromARGB(255, 43, 43, 43),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: kColorScheme),
      initialRoute: kFineRegisterRoute,
      routes: kRoutes,
    );
  }
}
