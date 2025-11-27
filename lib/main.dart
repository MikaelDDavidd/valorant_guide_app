import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Valorant Guide",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
