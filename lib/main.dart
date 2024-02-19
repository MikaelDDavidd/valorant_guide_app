import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/agent_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/home_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/maps_controller.dart';
import 'package:valorant_guide_app/app/modules/home/controllers/weapon_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  final dio = Dio();
  Get.put(AgentController());
  Get.put(MapsController());
  Get.put(WeaponController());
  Get.put(HomeController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Valorant Guide",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
