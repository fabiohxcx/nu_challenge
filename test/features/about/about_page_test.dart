import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nu_challenge/features/about/about_page.dart';

void main() {
  testWidgets('renders initial text when state is HomeInitial', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(home: AboutPage()));
    expect(find.text('About this App'), findsOneWidget);
  });
}
