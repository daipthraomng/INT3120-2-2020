import 'package:duolingo_demo/screens/lesson1.dart';
import 'package:duolingo_demo/screens/lesson2.dart';
import 'package:duolingo_demo/screens/lesson3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/home.dart';

void main() async {
  // Khởi tạo firebase
  // khi chạy phải 'flutter pub get'
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
      child: Home(),
    ));
  }
}
