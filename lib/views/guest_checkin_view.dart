import 'package:flutter/material.dart';
import '../controllers/booking_controller.dart';
import '../models/room.dart';

class GuestCheckInView extends StatefulWidget {
  final BookingController controller;
  final VoidCallback onOpenDashboard;
  final VoidCallback onOpenCheckOut;

  const GuestCheckInView({
    super.key,
    required this.controller,
    required this.onOpenDashboard,
    required this.onOpenCheckOut,
  });

  @override
  State<GuestCheckInView> createState() => _GuestCheckInViewState();
}

class _GuestCheckInViewState extends State<GuestCheckInView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      widget.controller.setSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--/--/----';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  Future<void> _pickCheckInDate(BuildContext context) async {
    final initialDate = widget.controller.checkInDate ?? widget.controller.today;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      helpText: 'SELECT CHECK-IN DATE',
      confirmText: 'SELECT',
    );
    if (picked != null) {
      widget.controller.setCheckInDate(picked);
    }
  }

  Future<void> _pickCheckOutDate(BuildContext context) async {
    final checkIn = widget.controller.checkInDate ?? widget.controller.today;
    final initialDate = widget.controller.checkOutDate ?? checkIn.add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2025, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      helpText: 'SELECT CHECK-OUT DATE',
      confirmText: 'SELECT',
    );
    if (picked != null) {
      widget.controller.setCheckOutDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final selectedRoom = ctrl.selectedRoom;
        final nights = ctrl.nights;
        final basePrice = ctrl.baseRoomCharge;
        final isValid = ctrl.isValid;
        final validationError = ctrl.validationError;

        return Scaffold(
          backgroundColor: const Color(0xFFF4F3EE),
          body: Column(
            children: [
              // Top browser / navigation bar
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Row: Card 1 (Select Booking & Guest) and Card 2 (Review & Update Details)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card 1
                          SizedBox(
                            width: 320,
                            child: _buildCard1SelectBooking(ctrl),
                          ),
                          const SizedBox(width: 14),
                          // Card 2
                          Expanded(
                            child: _buildCard2ReviewDetails(ctrl, selectedRoom),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Bottom Row: Table (Left/Center) + Card 3 Finalize (Right)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Table
                          Expanded(
                            flex: 7,
                            child: _buildRoomsTable(ctrl, selectedRoom),
                          ),
                          const SizedBox(width: 14),
                          // Card 3
                          SizedBox(
                            width: 330,
                            child: _buildCard3FinalizePayment(
                              ctrl,
                              selectedRoom,
                              nights,
                              basePrice,
                              isValid,
                              validationError,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E4E8), width: 1)),
      ),
      child: Row(
        children: [
          const Text(
            'Guest Check-in',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 32),
          // Search input in header
          Container(
            width: 380,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFDDE1E6)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                hintText: 'Search Booking ID / Guest Name / Room...',
                hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 9),
              ),
              style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
            ),
          ),
          const Spacer(),
          // Button to switch to Guest Check-out
          OutlinedButton.icon(
            onPressed: widget.onOpenCheckOut,
            icon: const Icon(Icons.exit_to_app_outlined, size: 15, color: Color(0xFF193E6B)),
            label: const Text(
              'Guest Check-out',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF193E6B)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF193E6B)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          const SizedBox(width: 10),
          // Button to switch to Main Dashboard
          OutlinedButton.icon(
            onPressed: widget.onOpenDashboard,
            icon: const Icon(Icons.dashboard_outlined, size: 16, color: Color(0xFF193E6B)),
            label: const Text(
              'Main Dashboard',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF193E6B)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF193E6B)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF143D66),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  // Card 1: 1. Select Booking & Guest
  Widget _buildCard1SelectBooking(BookingController ctrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E4E8)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader('1. Select Booking & Guest'),
          const SizedBox(height: 12),
          // Search Booking ID input
          Container(
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.search, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    ctrl.searchQuery.isEmpty ? 'Search Booking ID / Guest Name' : ctrl.searchQuery,
                    style: TextStyle(
                      fontSize: 12,
                      color: ctrl.searchQuery.isEmpty ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Select Customer',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ctrl.selectedRoom?.tenantName ?? 'Name/Phone number',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Color(0xFF334155)),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF64748B)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 14, color: Colors.white),
                label: const Text('Add Guest', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Booking / Check-in Date + Time
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Check-in Date',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () => _pickCheckInDate(context),
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: ctrl.validationError != null && ctrl.validationError!.contains('Check-in')
                                ? Colors.red.shade400
                                : const Color(0xFFCBD5E1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formatDate(ctrl.checkInDate),
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                              ),
                            ),
                            const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF1565C0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Time',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              '07:00 PM',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                            ),
                          ),
                          Icon(Icons.access_time, size: 14, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card 2: 2. Review & Update Details
  Widget _buildCard2ReviewDetails(BookingController ctrl, Room? selectedRoom) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E4E8)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader('2. Review & Update Details'),
          const SizedBox(height: 12),
          // Row 1: Room No (golden badge), Rent, GST, Tenant Name, Adults, Kids
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Golden Room badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Room No.', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                  const SizedBox(height: 4),
                  Container(
                    width: 95,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE5C58A), Color(0xFFD1A960)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFB58E45), width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4DB58E45),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bed, size: 16, color: Color(0xFF3E2D08)),
                        const SizedBox(width: 4),
                        Text(
                          selectedRoom?.code ?? '---',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF3E2D08),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              // Rent
              Expanded(
                flex: 2,
                child: _buildInputField(
                  label: 'Rent',
                  value: selectedRoom != null ? selectedRoom.pricePerNight.toStringAsFixed(2) : '0.00',
                  suffix: '₹',
                ),
              ),
              const SizedBox(width: 10),
              // GST
              Expanded(
                flex: 2,
                child: _buildInputField(
                  label: 'GST',
                  value: selectedRoom != null ? selectedRoom.gstPercentage.toStringAsFixed(2) : '12.00',
                  suffix: '%',
                ),
              ),
              const SizedBox(width: 10),
              // Tenant Name
              Expanded(
                flex: 3,
                child: _buildInputField(
                  label: 'Tenant Name',
                  value: selectedRoom?.tenantName ?? 'Mathew Hyden',
                ),
              ),
              const SizedBox(width: 10),
              // No-of Adults
              Expanded(
                flex: 2,
                child: _buildInputField(
                  label: 'No-of Adults',
                  value: '02',
                ),
              ),
              const SizedBox(width: 10),
              // No-of Kids
              Expanded(
                flex: 2,
                child: _buildInputField(
                  label: 'No-of Kids',
                  value: '00',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 2: Checkout Date, ID Proof, Update Adults/Kids, Additional Charges
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkout Date
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Checkout Date', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () => _pickCheckOutDate(context),
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: ctrl.validationError != null && ctrl.validationError!.contains('Check-out')
                                ? Colors.red.shade400
                                : const Color(0xFFCBD5E1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _formatDate(ctrl.checkOutDate),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                            ),
                            const Spacer(),
                            const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF1565C0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Update ID Proof
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Update ID Proof', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    const SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedRoom?.idProofName ?? 'mathewhyden.pdf',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 11, color: Color(0xFF334155)),
                            ),
                          ),
                          const Icon(Icons.description_outlined, size: 16, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Update No. of Adults/Kids
              Expanded(
                flex: 3,
                child: _buildInputField(
                  label: 'Update No. of Adults/Kids',
                  value: 'Mathew Hade',
                ),
              ),
              const SizedBox(width: 10),
              // Additional Charges Breakdown
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Additional Charges',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                      ),
                      const SizedBox(height: 3),
                      _buildChargesLine('Room Charge', '${ctrl.nights} nights @ ₹${selectedRoom?.pricePerNight.toInt() ?? 0}'),
                      _buildChargesLine('Extra Charges', '₹200.00'),
                      _buildChargesLine('Tax (${selectedRoom?.gstPercentage.toInt() ?? 12}%)', '₹${ctrl.state.taxAmount.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 3: Upload button, Guest count, Update Guest Name, and Action buttons
          Row(
            children: [
              // Upload box
              Container(
                width: 120,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload_outlined, size: 16, color: Color(0xFF475569)),
                    SizedBox(width: 4),
                    Text('Upload', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    SizedBox(width: 4),
                    Icon(Icons.insert_drive_file_outlined, size: 14, color: Color(0xFF64748B)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Guest Count dropdown
              SizedBox(
                width: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Guest Count', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    const SizedBox(height: 2),
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('02', style: TextStyle(fontSize: 11, color: Color(0xFF1E293B))),
                          Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Update Guest Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Update Guest Name', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    const SizedBox(height: 2),
                    Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: const Text('Mathew Hyden', style: TextStyle(fontSize: 11, color: Color(0xFF1E293B))),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              // Buttons: Delete, Edit, Update, Confirm Guest Details
              Row(
                children: [
                  _buildSecondaryButton(icon: Icons.delete_outline, label: 'Delete', color: const Color(0xFFDC2626)),
                  const SizedBox(width: 6),
                  _buildSecondaryButton(icon: Icons.edit_outlined, label: 'Edit', color: const Color(0xFF475569)),
                  const SizedBox(width: 6),
                  _buildSecondaryButton(icon: Icons.refresh, label: 'Update', color: const Color(0xFF475569)),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Guest details confirmed.'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Color(0xFF0F3A66),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F3A66),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Confirm Guest Details',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChargesLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
          Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required String value, String? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
        const SizedBox(height: 4),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
              ),
              if (suffix != null)
                Text(
                  suffix,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton({required IconData icon, required String label, required Color color}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14, color: color),
      label: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFFAF7F0),
        side: const BorderSide(color: Color(0xFFE2E4E8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  // Room Table
  Widget _buildRoomsTable(BookingController ctrl, Room? selectedRoom) {
    final rooms = ctrl.rooms;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E4E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFFAF8F5),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E4E8))),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                SizedBox(width: 115, child: Text('ROOM NO.', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 90, child: Text('RENT (₹)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 70, child: Text('GST', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                Expanded(flex: 3, child: Text('NAME / ROOM TYPE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 75, child: Text('ADULTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 65, child: Text('KIDS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 90, child: Text('CHECKOUT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 100, child: Text('ID PROOF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                SizedBox(width: 70, child: Text('ACTION', textAlign: TextAlign.right, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
              ],
            ),
          ),
          // Table Rows
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              final isSelected = selectedRoom?.code == room.code;

              return InkWell(
                onTap: () => ctrl.selectRoom(room),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEEF5FC) : (index.isEven ? Colors.white : const Color(0xFFFCFBFA)),
                    border: Border(
                      bottom: const BorderSide(color: Color(0xFFF1F5F9)),
                      left: isSelected ? const BorderSide(color: Color(0xFF0F3A66), width: 3) : BorderSide.none,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Room No with selection pill
                      SizedBox(
                        width: 115,
                        child: Row(
                          children: [
                            Text(
                              room.code,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                color: isSelected ? const Color(0xFF0F3A66) : const Color(0xFF1E293B),
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F3A66),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Text(
                                  'ACTIVE',
                                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Rent
                      SizedBox(
                        width: 90,
                        child: Text(
                          '₹${room.pricePerNight.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                        ),
                      ),
                      // GST
                      SizedBox(
                        width: 70,
                        child: Text(
                          '${room.gstPercentage.toInt()}%',
                          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ),
                      // Name & Room Type
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.tenantName ?? 'Guest',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                            ),
                            Text(
                              '${room.type} (Max ${room.maxGuests} guests)',
                              style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      // Adults
                      SizedBox(
                        width: 75,
                        child: Text('0${room.defaultAdults}', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                      ),
                      // Kids
                      SizedBox(
                        width: 65,
                        child: Text('0${room.defaultKids}', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                      ),
                      // Checkout date
                      SizedBox(
                        width: 90,
                        child: Text(
                          _formatDate(ctrl.checkOutDate),
                          style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
                        ),
                      ),
                      // ID Proof
                      SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                room.idProofName ?? 'id_proof.pdf',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11, color: Color(0xFF2563EB)),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.description_outlined, size: 14, color: Color(0xFF64748B)),
                          ],
                        ),
                      ),
                      // Action
                      const SizedBox(
                        width: 70,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.more_vert, size: 16, color: Color(0xFF64748B)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Card 3: 3. Finalize Check-in & Payment
  Widget _buildCard3FinalizePayment(
    BookingController ctrl,
    Room? selectedRoom,
    int nights,
    double basePrice,
    bool isValid,
    String? validationError,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E4E8)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader('3. Finalize Check-in & Payment'),
          const SizedBox(height: 12),

          // Date & Night calculation breakdown
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Stay Duration:', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    ),
                    Text(
                      '$nights night${nights == 1 ? '' : 's'}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Room Rate:', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    ),
                    Text(
                      '₹${selectedRoom?.pricePerNight.toStringAsFixed(2) ?? '0.00'} / night',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                const Divider(height: 12, thickness: 0.8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Room Charge (Nights × Rate):', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
                    ),
                    Text(
                      '₹${basePrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Extra Charges:', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
                    ),
                    Text(
                      '₹${ctrl.state.extraCharges.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text('Tax (${selectedRoom?.gstPercentage.toInt() ?? 12}% GST):', style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
                    ),
                    Text(
                      '₹${ctrl.state.taxAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Validation Banner (Alert if invalid, confirmation if valid)
          if (!isValid && validationError != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, size: 16, color: Color(0xFFDC2626)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      validationError,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFB91C1C)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ] else if (isValid) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF86EFAC)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF16A34A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '$nights nights valid stay • Total: ₹${ctrl.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF15803D)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Total Amount display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Total Amount:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF0F3A66)),
                ),
              ),
              Text(
                '₹${ctrl.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F3A66),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Total Paid:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                ),
              ),
              Text(
                '₹${ctrl.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Complete Check-in Primary button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: isValid
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Check-in complete for ${selectedRoom?.code}! Total: ₹${ctrl.totalPrice.toStringAsFixed(2)}'),
                          backgroundColor: const Color(0xFF0F3A66),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3A66),
                disabledBackgroundColor: const Color(0xFF94A3B8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                elevation: 0,
              ),
              child: const Text(
                'Complete Check-in',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Secondary Action buttons: Get Data, M-Pay, Print
          Row(
            children: [
              Expanded(
                child: _buildSmallActionButton('Get Data'),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildSmallActionButton('M-Pay', icon: Icons.credit_card),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildSmallActionButton('Print', icon: Icons.print),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Print Registration Card button
          SizedBox(
            width: double.infinity,
            height: 32,
            child: _buildSmallActionButton('Print Registration Card'),
          ),
          const SizedBox(height: 8),

          // Download Folio + Complete Check-in row
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: _buildSmallActionButton('Download Folio'),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: isValid ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F3A66),
                      disabledBackgroundColor: const Color(0xFF94A3B8),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text('Complete Check-in', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallActionButton(String label, {IconData? icon}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFFAF7F0),
        side: const BorderSide(color: Color(0xFFCBD5E1)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: const Color(0xFF334155)),
            const SizedBox(width: 2),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
            ),
          ),
        ],
      ),
    );
  }
}
