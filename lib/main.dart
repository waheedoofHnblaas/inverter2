import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/route.dart';

import 'core/services/services.dart';
import 'initialbinding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(),
        fontFamily: 'Cairo',
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.redAccent,
        backgroundColor: Colors.white,
      ),
    );
  }
}
