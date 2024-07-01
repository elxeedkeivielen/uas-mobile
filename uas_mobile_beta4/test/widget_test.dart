// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uas_mobile_beta4/main.dart';
import 'package:uas_mobile_beta4/pages/home_page.dart';

void main() {
  testWidgets('HomePage has a title and buttons', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify if HomePage is displayed
    expect(find.byType(HomePage), findsOneWidget);

    // Verify if the title is displayed
    expect(find.text('Bible App'), findsOneWidget);

    // Verify if the buttons are displayed
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Verse List'), findsOneWidget);
  });
}
