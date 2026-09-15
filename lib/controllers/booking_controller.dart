import 'package:flutter/material.dart';
import '../models/room.dart';
import '../models/booking_state.dart';

class BookingController extends ChangeNotifier {
  final List<Room> _rooms;
  BookingState _state;
  String _searchQuery = '';
  DateTime? _simulatedNow;

  BookingController({
    List<Room>? rooms,
    DateTime? initialCheckIn,
    DateTime? initialCheckOut,
    Room? initialRoom,
    DateTime? simulatedNow,
  })  : _rooms = rooms ?? Room.getSampleRooms(),
        _simulatedNow = simulatedNow,
        _state = BookingState(
          selectedRoom: initialRoom ?? (rooms ?? Room.getSampleRooms()).first,
          checkInDate: initialCheckIn ?? DateTime(2026, 4, 2),
          checkOutDate: initialCheckOut ?? DateTime(2026, 4, 5),
        ) {
    _validateAndCalculate();
  }

  List<Room> get rooms {
    if (_searchQuery.trim().isEmpty) return _rooms;
    final query = _searchQuery.toLowerCase();
    return _rooms.where((room) {
      return room.code.toLowerCase().contains(query) ||
          room.type.toLowerCase().contains(query) ||
          (room.tenantName?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  BookingState get state => _state;
  Room? get selectedRoom => _state.selectedRoom;
  DateTime? get checkInDate => _state.checkInDate;
  DateTime? get checkOutDate => _state.checkOutDate;
  String? get validationError => _state.validationError;
  int get nights => _state.nights;
  double get baseRoomCharge => _state.baseRoomCharge;
  double get totalPrice => _state.totalPrice;
  bool get isValid => _state.isValid;
  String get searchQuery => _searchQuery;

  /// Current reference date normalized to year-month-day
  DateTime get today {
    final now = _simulatedNow ?? DateTime.now();
    return BookingState.normalizeDate(now);
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectRoom(Room room) {
    _state = _state.copyWith(selectedRoom: room);
    _validateAndCalculate();
    notifyListeners();
  }

  void setCheckInDate(DateTime date) {
    _state = _state.copyWith(checkInDate: BookingState.normalizeDate(date));
    _validateAndCalculate();
    notifyListeners();
  }

  void setCheckOutDate(DateTime date) {
    _state = _state.copyWith(checkOutDate: BookingState.normalizeDate(date));
    _validateAndCalculate();
    notifyListeners();
  }

  void setAdultsCount(int count) {
    _state = _state.copyWith(adultsCount: count);
    notifyListeners();
  }

  void setKidsCount(int count) {
    _state = _state.copyWith(kidsCount: count);
    notifyListeners();
  }

  void setGuestName(String name) {
    _state = _state.copyWith(guestName: name);
    notifyListeners();
  }

  /// Sets simulated current time (useful for deterministic testing across time zones)
  void setSimulatedNow(DateTime? now) {
    _simulatedNow = now;
    _validateAndCalculate();
    notifyListeners();
  }

  /// Core validation and calculation logic
  void _validateAndCalculate() {
    // 1. Check if room is selected
    if (_state.selectedRoom == null) {
      _state = _state.copyWith(validationError: 'Please select a room from the list.');
      return;
    }

    // 2. Check if dates are selected
    if (_state.checkInDate == null) {
      _state = _state.copyWith(validationError: 'Please select a Check-in date.');
      return;
    }

    if (_state.checkOutDate == null) {
      _state = _state.copyWith(validationError: 'Please select a Check-out date.');
      return;
    }

    final inDate = BookingState.normalizeDate(_state.checkInDate!);
    final outDate = BookingState.normalizeDate(_state.checkOutDate!);
    final currentDay = today;

    // 3. Check-in cannot be in the past
    if (inDate.isBefore(currentDay)) {
      _state = _state.copyWith(
        validationError: 'Check-in date cannot be in the past.',
      );
      return;
    }

    // 4. Same-day check-in & check-out validation
    if (inDate.isAtSameMomentAs(outDate)) {
      _state = _state.copyWith(
        validationError: 'Check-out date must be at least 1 night after check-in (same-day check-out is not allowed).',
      );
      return;
    }

    // 5. Check-out must be after check-in
    if (outDate.isBefore(inDate)) {
      _state = _state.copyWith(
        validationError: 'Check-out date must be strictly after check-in date.',
      );
      return;
    }

    // Validation succeeded!
    _state = _state.copyWith(clearValidationError: true);
  }

  /// Explicit validation check for external callers / tests
  String? validateDates({
    required DateTime? checkIn,
    required DateTime? checkOut,
    DateTime? referenceToday,
  }) {
    if (checkIn == null) return 'Please select a Check-in date.';
    if (checkOut == null) return 'Please select a Check-out date.';

    final inDate = BookingState.normalizeDate(checkIn);
    final outDate = BookingState.normalizeDate(checkOut);
    final refToday = referenceToday != null
        ? BookingState.normalizeDate(referenceToday)
        : today;

    if (inDate.isBefore(refToday)) {
      return 'Check-in date cannot be in the past.';
    }
    if (inDate.isAtSameMomentAs(outDate)) {
      return 'Check-out date must be at least 1 night after check-in (same-day check-out is not allowed).';
    }
    if (outDate.isBefore(inDate)) {
      return 'Check-out date must be strictly after check-in date.';
    }
    return null;
  }
}
