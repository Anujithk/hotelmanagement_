import 'room.dart';

class BookingState {
  final Room? selectedRoom;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int adultsCount;
  final int kidsCount;
  final String bookingTime;
  final double extraCharges;
  final String guestName;
  final String idProof;
  final String? validationError;

  const BookingState({
    this.selectedRoom,
    this.checkInDate,
    this.checkOutDate,
    this.adultsCount = 2,
    this.kidsCount = 0,
    this.bookingTime = '07:00 PM',
    this.extraCharges = 200.0,
    this.guestName = 'Mathew Hyden',
    this.idProof = 'mathewhyden.pdf',
    this.validationError,
  });

  /// Normalize a DateTime to only year, month, day for date-only comparison.
  static DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Calculates number of nights if both dates are selected.
  int get nights {
    if (checkInDate == null || checkOutDate == null) return 0;
    final inDate = normalizeDate(checkInDate!);
    final outDate = normalizeDate(checkOutDate!);
    final diff = outDate.difference(inDate).inDays;
    return diff > 0 ? diff : 0;
  }

  /// Base room charge: nights * room price per night.
  double get baseRoomCharge {
    if (selectedRoom == null) return 0.0;
    return nights * selectedRoom!.pricePerNight;
  }

  /// Tax calculated based on GST rate.
  double get taxAmount {
    if (selectedRoom == null) return 0.0;
    return (baseRoomCharge * (selectedRoom!.gstPercentage / 100.0));
  }

  /// Total price inclusive of base charges, extra charges, and taxes.
  double get totalPrice {
    if (selectedRoom == null || nights == 0) return 0.0;
    return baseRoomCharge + extraCharges + taxAmount;
  }

  bool get isValid => validationError == null && selectedRoom != null && nights > 0;

  BookingState copyWith({
    Room? selectedRoom,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? adultsCount,
    int? kidsCount,
    String? bookingTime,
    double? extraCharges,
    String? guestName,
    String? idProof,
    String? validationError,
    bool clearValidationError = false,
  }) {
    return BookingState(
      selectedRoom: selectedRoom ?? this.selectedRoom,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      adultsCount: adultsCount ?? this.adultsCount,
      kidsCount: kidsCount ?? this.kidsCount,
      bookingTime: bookingTime ?? this.bookingTime,
      extraCharges: extraCharges ?? this.extraCharges,
      guestName: guestName ?? this.guestName,
      idProof: idProof ?? this.idProof,
      validationError: clearValidationError ? null : (validationError ?? this.validationError),
    );
  }
}
