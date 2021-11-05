// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bishop_assistant_web_test_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'home_page_tests/find_organization_page_test.dart';
import 'home_page_tests/home_page_mobile_test.dart';
import 'home_page_tests/home_page_test.dart';
import 'home_page_tests/home_page_web_test.dart';
import 'login_page_tests/login_page_test.dart';
import 'repository_tests/firebase_account_repository_test.dart';
import 'sign_up_tests/sign_up_page_test.dart';

void exampleTest() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

void main() {
  runFirebaseAccountRepositoryTests();
  runSignUpPageTests();
  runLoginPageTests();
  group("Home Page Tests", () {
    runHomePageTests();
    runHomePageMobileTests();
    runHomePageWebTests();
    runFindOrganizationPageTests();
  });
}
