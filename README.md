# Hotel Management & Room Check-In System

An exact, high-fidelity implementation of the Hotel Management and Guest Check-In system built with **Flutter (Dart)**. It provides complete date validation, automated night and price calculations, interactive room selection, and pixel-perfect representations of both the **Guest Check-In** and **Main Dashboard** interfaces.

---

## 🛠 Framework Choice

- **Framework**: **Flutter (Dart)**
- **Target Platforms**: Windows Desktop, Web (Chrome/Edge), macOS, Linux, Android, iOS.
- **Why Flutter?**:
  - Delivers pixel-perfect reproduction of complex desktop dashboards with custom styling, custom badge gradients, and responsive data tables.
  - Strong typing with Dart ensures compile-time safety and clean separation between business logic and UI.
  - Zero third-party dependency overhead: uses pure Flutter Material architecture and reactive state management (`ChangeNotifier`).

---

## 📋 Sample Room Data

Hardcoded directly into `lib/models/room.dart` according to the exact project specification:

| Room Code | Room Type | Price / Night (₹) | Max Guests | Floor | Default GST |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **R101** | Deluxe Room | ₹3,500.00 | 2 | 1 | 12% |
| **R102** | Deluxe Room | ₹3,500.00 | 2 | 1 | 12% |
| **R201** | Executive Suite | ₹5,800.00 | 3 | 2 | 18% |
| **R202** | Executive Suite | ₹5,800.00 | 3 | 2 | 18% |
| **R301** | Family Room | ₹4,200.00 | 4 | 3 | 12% |

*(Extended property demo rooms matching the dashboard mockups are also included in the table).*

---

## 🧮 Calculation Logic & Formula

1. **Nights Calculation**:
   $$\text{Nights} = \text{Check-out Date} - \text{Check-in Date} \quad (\text{normalized to calendar days})$$
2. **Base Room Charge**:
   $$\text{Base Room Charge} = \text{Nights} \times \text{Price Per Night}$$
3. **Total Amount Breakdown**:
   $$\text{Total Amount} = \text{Base Room Charge} + \text{Extra Charges} + \text{Tax (GST)}$$
   - Prominently shown in **3. Finalize Check-in & Payment** with a live rate formula (e.g. `3 nights @ ₹3,500 = ₹10,500.00`).

---

## 🛡 Date Validation & Edge Case Handling

The application validates user inputs reactively and displays explicit error banners instead of failing silently:

| Scenario / Edge Case | Validation Result | Visual Feedback in UI |
| :--- | :--- | :--- |
| **Past Date** (`checkIn < today`) | ❌ Invalid | Red banner: `"Check-in date cannot be in the past."` Check-in button disabled. |
| **Same-Day Stay** (`checkOut == checkIn`) | ❌ Invalid | Red banner: `"Check-out date must be at least 1 night after check-in (same-day check-out is not allowed)."` |
| **Invalid Range** (`checkOut < checkIn`) | ❌ Invalid | Red banner: `"Check-out date must be strictly after check-in date."` |
| **No Room Selected** | ❌ Invalid | Yellow banner: `"Please select a room from the list."` |
| **Valid Range & Room** | ✅ Valid | Green confirmation banner: `"[X] nights valid stay • Total: ₹[Total]"` |

---

## 🏗 Architecture & Code Structure

The project strictly separates business logic, data models, and presentation widgets:

```
lib/
├── models/
│   ├── room.dart             # Room entity, status enum, and sample data provider
│   └── booking_state.dart    # Immutable booking state, computed nights & prices
├── controllers/
│   └── booking_controller.dart # Reactive business logic controller & date validators
├── views/
│   ├── guest_checkin_view.dart # Exact recreation of Image 2 (3 cards + room table)
│   └── dashboard_view.dart     # Exact recreation of Image 1 (Raintech HOTEL dashboard)
└── main.dart                   # Application entrypoint, theme, and view navigation
```

---

## 🎨 UI Overview

1. **Guest Check-in (Image 2)**:
   - **Header**: Top search bar for Booking ID / Guest Name / Room + View switcher.
   - **Card 1 (`1. Select Booking & Guest`)**: Customer dropdown, `+ Add Guest` button, Check-in Date picker dialog, and booking time display.
   - **Card 2 (`2. Review & Update Details`)**: Golden brass plaque badge for the selected room, rent, GST, adults/kids counters, Checkout Date picker dialog, ID proof pill, and action buttons.
   - **Rooms Table**: Complete property room table with Room No, Rent, GST, Type/Name, Guests, Checkout date, ID proof, and interactive selection on click.
   - **Card 3 (`3. Finalize Check-in & Payment`)**: Calculation summary breakdown (`Nights × Rate`), tax, total amount, real-time validation error/success banner, and completion buttons.

2. **Main Dashboard (Image 1)**:
   - Brand crest header for **Raintech HOTEL**, search bar, date/time, and Quick Actions.
   - **12 Quick Action Tiles**: Guest Check-in, Guest Check-Out, Reservations, Housekeeping, Restaurant, WhatsApp, Rooms, Staff ("2 tasks"), Floors, Reports, Settings, Group Booking.
   - **Operational Overview**: Occupancy 4%, Pending Check-ins, Pending Departures, Revenue Today.
   - **Interactive Room Floor View**: Color-coded Floor 1 & Floor 2 room grid (Available, Occupied, Dirty, Maintenance, Blocked) and circular 200 rooms donut gauge.
   - **Going to Vacate Rooms & Quick Status Changer**.

---

## 🧪 Testing & Verification

Comprehensive unit and widget tests covering all calculation logic and validation rules:

```bash
# Run all automated tests
flutter test
```

### Test Coverage Summary:
- ✅ Room model verification for `R101`, `R102`, `R201`, `R202`, `R301` prices and max guests.
- ✅ Accurate night calculations and base room charge formulas.
- ✅ Instant recalculation upon selecting a different room.
- ✅ Validation edge case: check-in in the past.
- ✅ Validation edge case: check-in today allowed.
- ✅ Validation edge case: same-day check-in & check-out rejected.
- ✅ Validation edge case: check-out before check-in rejected.
- ✅ Full widget test verifying rendering of Guest Check-in interface, sample rooms, and price breakdown.

---

## 🚀 Running the Application

```bash
# Run on Windows Desktop
flutter run -d windows

# Run on Chrome / Web
flutter run -d chrome
```

---

## 📜 Git Commit History

Development followed a structured, incremental Git workflow:
1. `2d4fe98`: Initial commit: Flutter project baseline
2. `9642be5`: `feat: add Room models, BookingController, and unit tests for date validation & price calculations`
3. `16cd8a8`: `feat: add Guest Check-In view with booking selection and payment finalization`
4. `7771758`: `feat: implement GuestCheckInView, DashboardView, and responsive desktop layout`
5. `[latest]`: `docs: update README with architecture, validation rules, and run instructions`
