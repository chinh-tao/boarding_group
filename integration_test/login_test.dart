import 'package:boarding_group/app/modules/home/views/components/body/Body.dart';
import 'package:boarding_group/app/modules/login/bindings/login_binding.dart';
import 'package:boarding_group/app/modules/login/views/login_view.dart';
import 'package:boarding_group/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Test login', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Required text error', (WidgetTester tester) async {
      await tester.pumpWidget(GetMaterialApp(
          getPages: AppPages.routes,
          initialBinding: LoginBinding(),
          home: const LoginView()));

      Finder loginButton = find.byType(ElevatedButton);
      await tester.press(loginButton);
      await tester.pumpAndSettle(Duration(seconds: 3));

      Finder error = find.text('thông tin không được để trống');

      expect(error, findsNWidgets(2));
    });

    // testWidgets(
    //     'Test validation, if the validation is correct, it will go to the home screen',
    //     (WidgetTester tester) async {
    //   await tester.pumpWidget(GetMaterialApp(
    //       getPages: AppPages.routes,
    //       initialBinding: LoginBinding(),
    //       home: const LoginView()));
    //   Finder inputEmail = find.byKey(const ValueKey('email'));
    //   Finder inputPass = find.byKey(const ValueKey('password'));
    //   await tester.enterText(inputEmail, 'chinhtao1908@gmail.com');
    //   await tester.enterText(inputPass, '');

    //   Finder loginButton = find.byType(ElevatedButton);
    //   await tester.press(loginButton);
    //   await tester.pumpAndSettle(Duration(seconds: 2));

    //   Finder bodyHome = find.byType(SizedBox);

    //   expect(bodyHome, findsWidgets);
    // });
  });
}
