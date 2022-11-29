import 'dart:async';

import 'package:boarding_group/app/common/config.dart';
import 'package:boarding_group/app/common/custom_interceptor.dart';
import 'package:boarding_group/app/common/global.dart';
import 'package:boarding_group/app/common/utils.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

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
    GetStorage.init();
    runApp(const ProviderScope(child: MyApp()));
  }, (err, stackTrace) {
    _log.e("App Error: $err");
    _log.d("StackTrace: $stackTrace");
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Utils.handleUnfocus(),
      child: MaterialApp(
        navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        title: "CARO",
        initialRoute: AppPages.INITIAL,
        routes: AppPages.routes,
        theme: ThemeData(
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: kBodyText, displayColor: kBodyText)),
      ),
    );
  }
}
