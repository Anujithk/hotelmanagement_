import 'package:flutter_test/flutter_test.dart';
import 'package:hotelmanagement/controllers/booking_controller.dart';
import 'package:hotelmanagement/models/room.dart';

void main() {
  group('Room Model & Sample Data Tests', () {
    test('contains all prompt-required sample rooms with exact prices and guest limits', () {
      final rooms = Room.getSampleRooms();
      final r101 = rooms.firstWhere((r) => r.code == 'R101');
      final r102 = rooms.firstWhere((r) => r.code == 'R102');
      final r201 = rooms.firstWhere((r) => r.code == 'R201');
      final r202 = rooms.firstWhere((r) => r.code == 'R202');
      final r301 = rooms.firstWhere((r) => r.code == 'R301');

      expect(r101.type, equals('Deluxe Room'));
      expect(r101.pricePerNight, equals(3500.0));
      expect(r101.maxGuests, equals(2));

      expect(r102.type, equals('Deluxe Room'));
      expect(r102.pricePerNight, equals(3500.0));
      expect(r102.maxGuests, equals(2));

      expect(r201.type, equals('Executive Suite'));
      expect(r201.pricePerNight, equals(5800.0));
      expect(r201.maxGuests, equals(3));

      expect(r202.type, equals('Executive Suite'));
      expect(r202.pricePerNight, equals(5800.0));
      expect(r202.maxGuests, equals(3));

      expect(r301.type, equals('Family Room'));
      expect(r301.pricePerNight, equals(4200.0));
      expect(r301.maxGuests, equals(4));
    });
  });

  group('Booking Calculation & Validation Tests', () {
    final simulatedToday = DateTime(2026, 9, 15);

    test('calculates correct nights and total price for valid date range', () {
      final controller = BookingController(simulatedNow: simulatedToday);
      final room = controller.rooms.firstWhere((r) => r.code == 'R101');

      controller.selectRoom(room);
      controller.setCheckInDate(DateTime(2026, 9, 20));
      controller.setCheckOutDate(DateTime(2026, 9, 23)); // 3 nights

      expect(controller.nights, equals(3));
      expect(controller.baseRoomCharge, equals(3 * 3500.0)); // 10,500
      expect(controller.validationError, isNull);
      expect(controller.isValid, isTrue);
    });

    test('recalculates immediately when a different room is selected', () {
      final controller = BookingController(simulatedNow: simulatedToday);
      final r201 = controller.rooms.firstWhere((r) => r.code == 'R201'); // 5800

      controller.setCheckInDate(DateTime(2026, 9, 20));
      controller.setCheckOutDate(DateTime(2026, 9, 22)); // 2 nights
      controller.selectRoom(r201);

      expect(controller.nights, equals(2));
      expect(controller.baseRoomCharge, equals(2 * 5800.0)); // 11,600
    });

    test('validates single night stay correctly', () {
      final controller = BookingController(simulatedNow: simulatedToday);
      final r301 = controller.rooms.firstWhere((r) => r.code == 'R301'); // 4200

      controller.selectRoom(r301);
      controller.setCheckInDate(DateTime(2026, 9, 20));
      controller.setCheckOutDate(DateTime(2026, 9, 21)); // 1 night

      expect(controller.nights, equals(1));
      expect(controller.baseRoomCharge, equals(4200.0));
      expect(controller.validationError, isNull);
    });

    test('edge case: check-in in the past fails with clear message', () {
      final controller = BookingController(simulatedNow: simulatedToday);

      // Try booking yesterday
      controller.setCheckInDate(DateTime(2026, 9, 14));
      controller.setCheckOutDate(DateTime(2026, 9, 18));

      expect(controller.validationError, equals('Check-in date cannot be in the past.'));
      expect(controller.isValid, isFalse);
    });

    test('edge case: check-in today is allowed', () {
      final controller = BookingController(simulatedNow: simulatedToday);

      // Check-in on simulated today (2026-09-15)
      controller.setCheckInDate(DateTime(2026, 9, 15));
      controller.setCheckOutDate(DateTime(2026, 9, 17)); // 2 nights

      expect(controller.validationError, isNull);
      expect(controller.nights, equals(2));
      expect(controller.isValid, isTrue);
    });

    test('edge case: same-day check-in and check-out fails validation', () {
      final controller = BookingController(simulatedNow: simulatedToday);

      controller.setCheckInDate(DateTime(2026, 9, 20));
      controller.setCheckOutDate(DateTime(2026, 9, 20));

      expect(controller.validationError,
          contains('Check-out date must be at least 1 night after check-in'));
      expect(controller.isValid, isFalse);
    });

    test('edge case: check-out before check-in fails validation', () {
      final controller = BookingController(simulatedNow: simulatedToday);

      controller.setCheckInDate(DateTime(2026, 9, 25));
      controller.setCheckOutDate(DateTime(2026, 9, 20));

      expect(controller.validationError,
          equals('Check-out date must be strictly after check-in date.'));
      expect(controller.isValid, isFalse);
    });
  });
}
