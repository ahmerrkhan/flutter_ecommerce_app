import 'package:flutter/material.dart';
import 'package:flutter_application_3/views/sign_in_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter AALogics Test',
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
