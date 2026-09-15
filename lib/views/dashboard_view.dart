import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  final VoidCallback onOpenCheckIn;
  final VoidCallback onOpenCheckOut;

  const DashboardView({
    super.key,
    required this.onOpenCheckIn,
    required this.onOpenCheckOut,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F0),
      body: Column(
        children: [
          // Top Header Bar
          _buildTopBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Main Dashboard',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Top Section: 12 Quick Action Cards + Operational Overview
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Action Tiles (6 columns x 2 rows)
                      Expanded(
                        flex: 7,
                        child: _buildActionTilesGrid(context),
                      ),
                      const SizedBox(width: 16),
                      // Operational Overview Card
                      SizedBox(
                        width: 260,
                        child: _buildOperationalOverview(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Middle Section: Room Status - Interactive Floor View
                  _buildInteractiveFloorView(),
                  const SizedBox(height: 18),

                  // Bottom Section: Going to Vacate Rooms + Quick Room Status Changer
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Going to Vacate Rooms
                      Expanded(
                        flex: 6,
                        child: _buildVacateRoomsSection(),
                      ),
                      const SizedBox(width: 16),
                      // Quick Room Status Changer
                      Expanded(
                        flex: 4,
                        child: _buildQuickStatusChanger(),
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
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E4E8))),
      ),
      child: Row(
        children: [
          // Brand Logo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF0F3A66),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Icon(Icons.hotel, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'DOOI',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Raintech',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
              ),
              Text(
                'HOTEL',
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF64748B), letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(width: 24),

          // Search Bar
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search guests, rooms, reservations, staff...',
                      style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                    ),
                  ),
                  Text(
                    'Ctrl+K',
                    style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Date & Time
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF64748B)),
                SizedBox(width: 6),
                Text(
                  'Thu, Jul 23, 2026 | 9:30 AM',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Quick Actions Button
          ElevatedButton.icon(
            onPressed: onOpenCheckIn,
            icon: const Icon(Icons.bolt, size: 14, color: Colors.white),
            label: const Text('Quick Actions', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C5E8A),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
          ),
          const SizedBox(width: 14),

          // Notification Bell
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, size: 20, color: Color(0xFF475569)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // User Avatar
          const CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xFF1E293B),
            child: Icon(Icons.person, size: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // 12 Action Tiles Grid
  Widget _buildActionTilesGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                title: 'Guest Check-in',
                icon: Icons.assignment_turned_in_outlined,
                iconBg: const Color(0xFFDCFCE7),
                iconColor: const Color(0xFF16A34A),
                onTap: onOpenCheckIn,
                isPrimary: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Guest Check-Out',
                icon: Icons.exit_to_app_outlined,
                iconBg: const Color(0xFFFFEDD5),
                iconColor: const Color(0xFFEA580C),
                onTap: onOpenCheckOut,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Reservations',
                icon: Icons.calendar_month_outlined,
                iconBg: const Color(0xFFE0E7FF),
                iconColor: const Color(0xFF4F46E5),
                onTap: onOpenCheckIn,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Housekeeping',
                icon: Icons.cleaning_services_outlined,
                iconBg: const Color(0xFFCCFBF1),
                iconColor: const Color(0xFF0D9488),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Restaurant',
                icon: Icons.restaurant_outlined,
                iconBg: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFD97706),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'WhatsApp',
                icon: Icons.chat_bubble_outline,
                iconBg: const Color(0xFFDCFCE7),
                iconColor: const Color(0xFF16A34A),
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildActionTile(
                title: 'Rooms',
                icon: Icons.meeting_room_outlined,
                iconBg: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF9333EA),
                onTap: onOpenCheckIn,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Staff',
                icon: Icons.badge_outlined,
                iconBg: const Color(0xFFE0E7FF),
                iconColor: const Color(0xFF4338CA),
                badgeText: '2 tasks',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Floors',
                icon: Icons.layers_outlined,
                iconBg: const Color(0xFFCCFBF1),
                iconColor: const Color(0xFF0F766E),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Reports',
                icon: Icons.bar_chart_outlined,
                iconBg: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFCA8A04),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'Settings',
                icon: Icons.tune_outlined,
                iconBg: const Color(0xFFF1F5F9),
                iconColor: const Color(0xFF475569),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionTile(
                title: 'New: Group Booking',
                icon: Icons.group_add_outlined,
                iconBg: const Color(0xFFEFF6FF),
                iconColor: const Color(0xFF2563EB),
                onTap: onOpenCheckIn,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    String? badgeText,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isPrimary ? const Color(0xFF0F3A66) : const Color(0xFFE2E4E8),
            width: isPrimary ? 1.5 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 17, color: iconColor),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                ),
              ],
            ),
            if (badgeText != null)
              Positioned(
                top: 4,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: Text(
                    badgeText,
                    style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Color(0xFF92400E)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Operational Overview Card
  Widget _buildOperationalOverview() {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E4E8)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operational Overview',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildMetricTile(label: 'Occupancy', value: '4%', indicatorColor: const Color(0xFF2563EB)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(label: 'Pending Check-ins', value: '0'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildMetricTile(label: 'Pending Departures', value: '0'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricTile(label: 'Revenue Today', value: '₹0', valueColor: const Color(0xFF15803D)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    Color? indicatorColor,
    Color? valueColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              if (indicatorColor != null) ...[
                Container(
                  width: 3,
                  height: 14,
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 5),
              ],
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: valueColor ?? const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Interactive Floor View
  Widget _buildInteractiveFloorView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E4E8)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Room Status - Interactive Floor View',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
          ),
          const Text(
            '50 rooms across your property',
            style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grid for Floor 1 & Floor 2
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    _buildFloorGridRow(
                      floorLabel: 'Floor 1',
                      rows: [
                        ['101', '102', '103', '104', '105', '106', '107', '108', '109', '109', '110', '111', '112', '113', '114', '115', '116'],
                        ['101', '102', '103', '104', '105', '106', '107', '102', '103', '104', '104', '105', '106', '107', '108', '109', '190'],
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildFloorGridRow(
                      floorLabel: 'Floor 2',
                      rows: [
                        ['201', '202', '203', '204', '205', '210', '207', '202', '203', '205', '210', '211', '212', '213', '214', '215', '216'],
                        ['201', '102', '204', '105', '106', '207', '202', '203', '204', '205', '206', '206', '207', '208', '209', '210', '210'],
                        ['201', '202', '203', '204', '205', '206', '207', '208', '209', '230', '201', '202', '203', '203', '204', '205', '206'],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // Mini Floor Grid + Circular Gauge
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Mini Floor Grid
                        Expanded(
                          child: Column(
                            children: [
                              _buildMiniFloor('Floor 1', ['101', '102', '103', '104', '105', '106']),
                              const SizedBox(height: 4),
                              _buildMiniFloor('Floor 2', ['201', '202', '203', '204', '205', '210']),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Donut Chart
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF22C55E), width: 6),
                          ),
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('200', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                              Text('Rooms', style: TextStyle(fontSize: 8, color: Color(0xFF64748B))),
                              Text('Total', style: TextStyle(fontSize: 8, color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text('4% Occupied', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Status Legend
          Row(
            children: [
              _buildLegendItem('Available', const Color(0xFF86EFAC)),
              const SizedBox(width: 12),
              _buildLegendItem('Occupied', const Color(0xFF60A5FA)),
              const SizedBox(width: 12),
              _buildLegendItem('Dirty', const Color(0xFFF87171)),
              const SizedBox(width: 12),
              _buildLegendItem('Maintenance', const Color(0xFFFDBA74)),
              const SizedBox(width: 12),
              _buildLegendItem('Blocked', const Color(0xFFCBD5E1)),
              const Spacer(),
              const Text(
                'Clicking a room tile opens its quick-edit menu',
                style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloorGridRow({required String floorLabel, required List<List<String>> rows}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            floorLabel,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: rows.map((row) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: row.map((roomNum) {
                    final color = _getRoomColor(roomNum);
                    return Expanded(
                      child: Container(
                        height: 24,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          roomNum,
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniFloor(String label, List<String> rooms) {
    return Row(
      children: [
        SizedBox(
          width: 38,
          child: Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
        ),
        Expanded(
          child: Row(
            children: rooms.map((room) {
              return Expanded(
                child: Container(
                  height: 20,
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF86EFAC),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.center,
                  child: Text(room, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w600)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getRoomColor(String roomNumber) {
    if (['102', '104', '202', '203'].contains(roomNumber)) {
      return const Color(0xFF93C5FD); // Occupied Blue
    } else if (['104', '105', '206'].contains(roomNumber)) {
      return const Color(0xFFFCA5A5); // Dirty Red
    } else if (['106', '107', '190', '205'].contains(roomNumber)) {
      return const Color(0xFFFDBA74); // Maintenance Orange
    } else if (['210', '211', '212', '213', '214', '215', '216'].contains(roomNumber)) {
      return const Color(0xFFE2E8F0); // Blocked Gray
    }
    return const Color(0xFFBBF7D0); // Available Green
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF475569))),
      ],
    );
  }

  // Going to Vacate Rooms
  Widget _buildVacateRoomsSection() {
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
          const Row(
            children: [
              Icon(Icons.bed_outlined, size: 16, color: Color(0xFF0F3A66)),
              SizedBox(width: 6),
              Text('Going to Vacate Rooms', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildVacateCard(
                  roomCode: 'Room 101',
                  status: 'Departing • Guest Check-Out Scheduled',
                  imageUrl: null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildVacateCard(
                  roomCode: 'Room 102',
                  status: 'Departing • Guest Checkout: 11:00 AM',
                  imageUrl: null,
                ),
              ),
              const SizedBox(width: 10),
              // Status counter
              Container(
                width: 120,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Departing', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                    Text('0', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                    SizedBox(height: 4),
                    Text('Room 101 cleaning overdue', style: TextStyle(fontSize: 8, color: Color(0xFFD97706))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVacateCard({required String roomCode, required String status, String? imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.hotel, size: 22, color: Color(0xFF64748B)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(roomCode, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                Text(status, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Quick Room Status Changer & Actions
  Widget _buildQuickStatusChanger() {
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
          const Text(
            'Quick Room Status Changer & Actions',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Enter number', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                      Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.cleaning_services, size: 14, color: Color(0xFF15803D)),
                  label: const Text('Cleaning done, ready to serve', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF15803D))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDCFCE7),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE4E6),
                    side: const BorderSide(color: Color(0xFFFECDD3)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text('Set all Dirty to Cleaning', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFBE123C))),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text('View All Maintenance', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
