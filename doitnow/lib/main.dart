import 'package:doitnow/controllers/drawer_controller.dart';
import 'package:doitnow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:doitnow/screens/login/login_screen.dart';
import 'package:get_it/get_it.dart';

void main() {
  registerSingletons();

  runApp(MyApp());
}

void registerSingletons(){
  GetIt.I.registerSingleton(CustomDrawerController());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Do It Now',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: Auth(),
    );
  }
}
