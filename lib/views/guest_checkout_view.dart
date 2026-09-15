import 'package:flutter/material.dart';

class GuestCheckOutView extends StatefulWidget {
  final VoidCallback onOpenCheckIn;
  final VoidCallback onOpenDashboard;

  const GuestCheckOutView({
    super.key,
    required this.onOpenCheckIn,
    required this.onOpenDashboard,
  });

  @override
  State<GuestCheckOutView> createState() => _GuestCheckOutViewState();
}

class _GuestCheckOutViewState extends State<GuestCheckOutView> {
  final TextEditingController _searchController = TextEditingController();
  bool _room101Selected = true;
  bool _room103Selected = true;
  String _paymentMethod = 'Credit Card';

  double get room101Total => 4550.0;
  double get room103Total => 3650.0; // 2400 room + 50 chips + 1200 restaurant = 3650

  double get combinedTotal {
    double total = 0.0;
    if (_room101Selected) total += room101Total;
    if (_room103Selected) total += room103Total;
    return total;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3EE),
      body: Column(
        children: [
          // Top Navigation Bar
          _buildTopBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: 1. Identify Departing Guest
                  SizedBox(
                    width: 320,
                    child: _buildColumn1IdentifyGuest(),
                  ),
                  const SizedBox(width: 14),
                  // Column 2: 2. Review & Finalize Bill
                  Expanded(
                    flex: 6,
                    child: _buildColumn2ReviewBill(),
                  ),
                  const SizedBox(width: 14),
                  // Column 3: 3. Payment & Check-out
                  SizedBox(
                    width: 320,
                    child: _buildColumn3PaymentCheckOut(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
            'Guest Check-out',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 32),
          // Search input
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
                hintText: 'Search Booking ID / Guest Name',
                hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 9),
              ),
              style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
            ),
          ),
          const Spacer(),
          // Navigation links
          OutlinedButton.icon(
            onPressed: widget.onOpenCheckIn,
            icon: const Icon(Icons.login, size: 15, color: Color(0xFF193E6B)),
            label: const Text(
              'Guest Check-in',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF193E6B)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF193E6B)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton.icon(
            onPressed: widget.onOpenDashboard,
            icon: const Icon(Icons.dashboard_outlined, size: 15, color: Color(0xFF193E6B)),
            label: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF193E6B)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF193E6B)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  // Column 1: 1. Identify Departing Guest
  Widget _buildColumn1IdentifyGuest() {
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
          _buildCardHeader('1. Identify Departing Guest'),
          const SizedBox(height: 12),

          // Find Guest & Identify by Room
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Find Guest', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    const SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Search Guest', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                          Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Identify by Room', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                    const SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_drop_up, size: 14, color: Color(0xFF64748B)),
                              Icon(Icons.arrow_drop_down, size: 14, color: Color(0xFF64748B)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Select Guest from List + Find Room/Guest button
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Select Guest from List',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Color(0xFF475569)),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3A66),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  elevation: 0,
                ),
                child: const Text('Find Room/Guest', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Guest Name & Room No badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Guest Name', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                  SizedBox(height: 2),
                  Text(
                    'Mathew Hyden',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Room No.', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                  const SizedBox(height: 2),
                  // Golden brass badge
                  Container(
                    width: 75,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE5C58A), Color(0xFFD1A960)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: const Color(0xFFB58E45), width: 1.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4DB58E45),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bed, size: 14, color: Color(0xFF3E2D08)),
                        SizedBox(width: 4),
                        Text(
                          '101',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF3E2D08)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Sub-table for Rooms to Check out
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8F5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E4E8)),
            ),
            child: Column(
              children: [
                // Table header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1EFEA),
                    border: Border(bottom: BorderSide(color: Color(0xFFE2E4E8))),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 40, child: Text('Room', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                      Expanded(child: Text('Stay Dates', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
                      Text('Actions', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                    ],
                  ),
                ),
                // Row 1: 101
                _buildRoomSelectionRow(
                  room: '101',
                  dates: '02/04/2026-04/04/2026',
                  selected: _room101Selected,
                  onChanged: (val) {
                    setState(() {
                      _room101Selected = val ?? false;
                    });
                  },
                ),
                const Divider(height: 1, thickness: 0.5, color: Color(0xFFE2E4E8)),
                // Row 2: 103
                _buildRoomSelectionRow(
                  room: '103',
                  dates: '02/04/2026-04/04/2026',
                  selected: _room103Selected,
                  onChanged: (val) {
                    setState(() {
                      _room103Selected = val ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Add/Change Selected Rooms button
          SizedBox(
            width: double.infinity,
            height: 34,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search, size: 14, color: Color(0xFF334155)),
              label: const Text(
                'Add/Change Selected Rooms',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFAF7F0),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomSelectionRow({
    required String room,
    required String dates,
    required bool selected,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(room, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
          ),
          Expanded(
            child: Text(dates, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: Checkbox(
                  value: selected,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF0F3A66),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                ),
              ),
              const SizedBox(width: 4),
              const Text('Select for Check-out', style: TextStyle(fontSize: 9, color: Color(0xFF475569))),
            ],
          ),
        ],
      ),
    );
  }

  // Column 2: 2. Review & Finalize Bill
  Widget _buildColumn2ReviewBill() {
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
          _buildCardHeader('2. Review & Finalize Bill'),
          const SizedBox(height: 12),

          // SECTION 1: [Room 101]
          if (_room101Selected) ...[
            _buildRoom101Section(),
            const SizedBox(height: 14),
          ],

          // SECTION 2: [Room 103]
          if (_room103Selected) ...[
            _buildRoom103Section(),
            const SizedBox(height: 14),
          ],

          // Selected Rooms Combined Total
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Selected Rooms Combined Total: ',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                ),
                Text(
                  '₹${combinedTotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF0F3A66)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoom101Section() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '[Room 101]',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
          ),
          const Text(
            '(Nights: 2, Rate: ₹1200.00, Total: ₹2400.00)',
            style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          // Additional Charges (Add Items)
          Row(
            children: [
              const Text('Additional Charges (Add Items)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 14, color: Color(0xFF94A3B8)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text('Search/Add Additional Charges', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              _buildAddChargePill('Mini-bar'),
              const SizedBox(width: 4),
              _buildAddChargePill('Laundry'),
              const SizedBox(width: 4),
              _buildAddChargePill('+', isIcon: true),
            ],
          ),
          const SizedBox(height: 8),

          // Bill Items Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFE2E4E8)),
            ),
            child: Column(
              children: [
                _buildBillTableHeader(),
                _buildBillItemRow('Mini-bar (Water x2)', '03/04/2026', '₹100.00'),
                _buildBillItemRow('Room Service', '03/04/2026', '₹1200.00'),
                _buildBillItemRow('Restaurant Bill (Room 101)', '03/04/2026', '₹850.00'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Room 101 Total
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Room 101 Total',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
              ),
              Text(
                '₹4550.00',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF0F3A66)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Action buttons: Print Room 101 Invoice & Adjust Charges
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print_outlined, size: 13, color: Color(0xFF334155)),
                label: const Text('Print Room 101 Invoice', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFFAF7F0),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sync_alt, size: 13, color: Colors.white),
                label: const Text('Adjust Charges (Room 101)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3A66),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoom103Section() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8F5),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '[Room 103]',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print_outlined, size: 13, color: Color(0xFF334155)),
                label: const Text('Print Draft Invoice', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFFAF7F0),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
              const SizedBox(width: 6),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sync_alt, size: 13, color: Colors.white),
                label: const Text('Adjust Charges', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3A66),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const Text(
            '(Nights: 2, Rate: ₹1200.00, Total: ₹2400.00)',
            style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          // Additional Charges (Add Items)
          Row(
            children: [
              const Text('Additional Charges (Add Items)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
              const Spacer(),
              _buildAddChargePill('Mini-bar'),
              const SizedBox(width: 4),
              _buildAddChargePill('Laundry'),
              const SizedBox(width: 4),
              _buildAddChargePill('+', isIcon: true),
            ],
          ),
          const SizedBox(height: 8),

          // Bill Items Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFE2E4E8)),
            ),
            child: Column(
              children: [
                _buildBillTableHeader(),
                _buildBillItemRow('Mini-bar (Chips)', '03/04/2026', '₹50.00'),
                _buildBillItemRow('Restaurant Bill (Room 103)', '03/04/2026', '₹1200.00'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Actions
          Row(
            children: [
              const Text('Room', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print_outlined, size: 13, color: Color(0xFF334155)),
                label: const Text('Print Room 103 Invoice', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFFAF7F0),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sync_alt, size: 13, color: Colors.white),
                label: const Text('Adjust Charges (Room 103)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F3A66),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddChargePill(String label, {bool isIcon = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isIcon ? 8 : 10, vertical: 4),
      decoration: BoxDecoration(
        color: isIcon ? const Color(0xFF0F3A66) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isIcon ? Colors.white : const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _buildBillTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E4E8))),
      ),
      child: const Row(
        children: [
          Expanded(child: Text('Room Charges & External Bills', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
          SizedBox(width: 80, child: Text('Date', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
          SizedBox(width: 70, child: Text('Amount', textAlign: TextAlign.right, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569)))),
        ],
      ),
    );
  }

  Widget _buildBillItemRow(String item, String date, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          Expanded(child: Text(item, style: const TextStyle(fontSize: 11, color: Color(0xFF1E293B)))),
          SizedBox(width: 80, child: Text(date, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)))),
          SizedBox(width: 70, child: Text(amount, textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)))),
        ],
      ),
    );
  }

  // Column 3: 3. Payment & Check-out
  Widget _buildColumn3PaymentCheckOut() {
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
          _buildCardHeader('3. Payment & Check-out'),
          const SizedBox(height: 12),

          // Total Amount Due
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount Due',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                  ),
                  Text(
                    '(Selected Rooms)',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${combinedTotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF0F3A66)),
                  ),
                  const Text(
                    '₹0.00',
                    style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Payment Method
          const Text('Payment Method', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_paymentMethod, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                      const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                _buildPaymentMethodOption('Cash'),
                _buildPaymentMethodOption('M-Pay'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Payment Amount
          const Text('Payment Amount', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          const SizedBox(height: 4),
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              '₹${combinedTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
            ),
          ),
          const SizedBox(height: 14),

          // Process Payment & Check-out button (Block 1)
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment processed for Room 101! Check-out complete.'),
                  backgroundColor: Color(0xFF0F3A66),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF0F3A66),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Column(
                children: [
                  Text(
                    'Process Payment & Check-out',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Proceed with Room 101 Check-out',
                    style: TextStyle(fontSize: 9, color: Color(0xFFCBD5E1)),
                  ),
                  Text(
                    'Complete Check-out',
                    style: TextStyle(fontSize: 9, color: Color(0xFFCBD5E1)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Combined Payment & Check-out button (Block 2)
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Combined Check-out processed! Total: ₹${combinedTotal.toStringAsFixed(2)}'),
                  backgroundColor: const Color(0xFF0F3A66),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF0F3A66),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Column(
                children: [
                  Text(
                    'Payment & Check-out',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Combine and Proceed with',
                    style: TextStyle(fontSize: 9, color: Color(0xFFCBD5E1)),
                  ),
                  Text(
                    'Selected Rooms Check-out',
                    style: TextStyle(fontSize: 9, color: Color(0xFFCBD5E1)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Bottom invoice buttons
          SizedBox(
            width: double.infinity,
            height: 32,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFAF7F0),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text('Print Final Invoice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFAF7F0),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text('Email Final Invoice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _paymentMethod = label;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
        ),
      ),
    );
  }
}
