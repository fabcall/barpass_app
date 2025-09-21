// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:barpass_app/app/app.dart';
import 'package:barpass_app/features/onboarding/views/onboarding_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(OnboardingPage), findsOneWidget);
    });
  });
}
