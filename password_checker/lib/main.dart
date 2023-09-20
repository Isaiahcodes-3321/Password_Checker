import 'package:flutter/material.dart';
import 'package:password_checker/input_Field.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: ChangeNotifierProvider( 
          create: (_) => Check_password(),
          child: Inputs(),
        ),
      ),
    );
  }
}








