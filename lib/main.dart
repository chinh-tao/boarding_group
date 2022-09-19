import 'dart:async';

import 'package:boarding_group/app/common/api.dart';
import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/custom_interceptor.dart';
import 'package:boarding_group/app/utils/utils.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'app/routes/app_pages.dart';

final _log = Logger();

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    api.options
      ..connectTimeout = 10000
      ..validateStatus = (int? status) => status != null && status > 0;
    api.interceptors.addAll([
      CustomInterceptors(),
      RetryInterceptor(
          dio: api,
          logPrint: print,
          retryDelays: [
            const Duration(seconds: 5),
            const Duration(seconds: 10),
            const Duration(seconds: 20)
          ],
          retries: 3)
    ]);
    runApp(const MyApp());
  }, (err, stackTrace) {
    _log.e("App Error: $err");
    _log.d("StackTrace: $stackTrace");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.handleUnfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "CARO",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: kBodyText, displayColor: kBodyText)),
      ),
    );
  }
}
