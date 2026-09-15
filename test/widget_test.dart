import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmanagement/main.dart';

void main() {
  testWidgets('HotelManagementApp renders Guest Check-in page and sample rooms', (WidgetTester tester) async {
    // Set desktop screen resolution for layout fidelity
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const HotelManagementApp());
    await tester.pumpAndSettle();

    // Verify top header
    expect(find.text('Guest Check-in'), findsWidgets);

    // Verify 3 sections
    expect(find.text('1. Select Booking & Guest'), findsOneWidget);
    expect(find.text('2. Review & Update Details'), findsOneWidget);
    expect(find.text('3. Finalize Check-in & Payment'), findsOneWidget);

    // Verify sample rooms are displayed in table
    expect(find.text('R101'), findsWidgets);
    expect(find.text('Deluxe Room (Max 2 guests)'), findsWidgets);

    // Verify price calculation breakdown is present
    expect(find.textContaining('Total Amount:'), findsOneWidget);
  });
}
