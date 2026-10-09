import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:luma_sleep/main.dart';

void main() {
  testWidgets('shows the tonight dashboard', (tester) async {
    await tester.pumpWidget(const LumaSleepApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Good evening'), findsOneWidget);
    expect(find.text('Start sleep tracking'), findsOneWidget);

    // Scroll down to reveal the sound monitor section
    await tester.drag(find.byType(CustomScrollView).first, const Offset(0, -600));
    await tester.pump();

    expect(find.text('Sound monitor'), findsOneWidget);
  });
}
