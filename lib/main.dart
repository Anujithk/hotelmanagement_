import 'package:flutter/material.dart';
import 'controllers/booking_controller.dart';
import 'views/guest_checkin_view.dart';
import 'views/guest_checkout_view.dart';
import 'views/dashboard_view.dart';

void main() {
  runApp(const HotelManagementApp());
}

class HotelManagementApp extends StatelessWidget {
  const HotelManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Management Pro - Hotel Room Management & Check-In / Check-Out',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: const Color(0xFFF4F3EE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F3A66),
          primary: const Color(0xFF0F3A66),
          secondary: const Color(0xFFD1A960),
          surface: Colors.white,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainAppShell(),
    );
  }
}

class MainAppShell extends StatefulWidget {
  const MainAppShell({super.key});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  late final BookingController _bookingController;
  int _currentViewIndex = 1; // 0: Guest Check-in, 1: Main Dashboard, 2: Guest Check-out

  @override
  void initState() {
    super.initState();
    _bookingController = BookingController();
  }

  @override
  void dispose() {
    _bookingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentViewIndex,
      children: [
        GuestCheckInView(
          controller: _bookingController,
          onOpenDashboard: () {
            setState(() {
              _currentViewIndex = 1;
            });
          },
          onOpenCheckOut: () {
            setState(() {
              _currentViewIndex = 2;
            });
          },
        ),
        DashboardView(
          onOpenCheckIn: () {
            setState(() {
              _currentViewIndex = 0;
            });
          },
          onOpenCheckOut: () {
            setState(() {
              _currentViewIndex = 2;
            });
          },
        ),
        GuestCheckOutView(
          onOpenCheckIn: () {
            setState(() {
              _currentViewIndex = 0;
            });
          },
          onOpenDashboard: () {
            setState(() {
              _currentViewIndex = 1;
            });
          },
        ),
      ],
    );
  }
}
