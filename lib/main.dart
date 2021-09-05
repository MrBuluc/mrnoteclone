import 'package:flutter/material.dart';

import 'app/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mr. Note Clone",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: LandingPage(),
    );
  }
}
