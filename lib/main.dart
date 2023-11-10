import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vedio_project/loginPage.dart';
import 'package:vedio_project/pages/homePage.dart';
import 'package:vedio_project/viewmodel/commonViewModel.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<viewmodel>(
        create: (context) => viewmodel(),
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LoginPage()));
  }
}
