enum RoomStatus {
  available,
  occupied,
  dirty,
  maintenance,
  blocked,
}

class Room {
  final String code;
  final String type;
  final double pricePerNight;
  final int maxGuests;
  final double gstPercentage;
  final RoomStatus status;
  final int floor;
  final String? tenantName;
  final int defaultAdults;
  final int defaultKids;
  final int seniorCitizens;
  final String? idProofName;

  const Room({
    required this.code,
    required this.type,
    required this.pricePerNight,
    required this.maxGuests,
    this.gstPercentage = 12.0,
    this.status = RoomStatus.available,
    this.floor = 1,
    this.tenantName,
    this.defaultAdults = 2,
    this.defaultKids = 0,
    this.seniorCitizens = 0,
    this.idProofName,
  });

  /// Hardcoded sample rooms according to prompt specification + UI mockups
  static List<Room> getSampleRooms() {
    return const [
      // Required prompt sample room data
      Room(
        code: 'R101',
        type: 'Deluxe Room',
        pricePerNight: 3500.0,
        maxGuests: 2,
        gstPercentage: 12.0,
        status: RoomStatus.occupied,
        floor: 1,
        tenantName: 'Mathew Hyden',
        defaultAdults: 2,
        defaultKids: 0,
        seniorCitizens: 2,
        idProofName: 'mathewhyden.pdf',
      ),
      Room(
        code: 'R102',
        type: 'Deluxe Room',
        pricePerNight: 3500.0,
        maxGuests: 2,
        gstPercentage: 12.0,
        status: RoomStatus.available,
        floor: 1,
        tenantName: 'Sarah Thompson',
        defaultAdults: 2,
        defaultKids: 3,
        seniorCitizens: 3,
        idProofName: 'sarahthomps.pdf',
      ),
      Room(
        code: 'R201',
        type: 'Executive Suite',
        pricePerNight: 5800.0,
        maxGuests: 3,
        gstPercentage: 18.0,
        status: RoomStatus.available,
        floor: 2,
        tenantName: 'James Smith',
        defaultAdults: 2,
        defaultKids: 4,
        seniorCitizens: 4,
        idProofName: 'jamessmithid.pdf',
      ),
      Room(
        code: 'R202',
        type: 'Executive Suite',
        pricePerNight: 5800.0,
        maxGuests: 3,
        gstPercentage: 18.0,
        status: RoomStatus.occupied,
        floor: 2,
        tenantName: 'Emily Clark',
        defaultAdults: 2,
        defaultKids: 5,
        seniorCitizens: 5,
        idProofName: 'emilyclarkid.pdf',
      ),
      Room(
        code: 'R301',
        type: 'Family Room',
        pricePerNight: 4200.0,
        maxGuests: 4,
        gstPercentage: 12.0,
        status: RoomStatus.available,
        floor: 3,
        tenantName: 'Michael Brown',
        defaultAdults: 2,
        defaultKids: 6,
        seniorCitizens: 0,
        idProofName: 'michaelBrown.pdf',
      ),

      // Additional UI demo rooms matching screenshot table
      Room(
        code: '107',
        type: 'Deluxe Room',
        pricePerNight: 1700.0,
        maxGuests: 2,
        gstPercentage: 12.0,
        status: RoomStatus.available,
        floor: 1,
        tenantName: 'Jessica Lee',
        defaultAdults: 2,
        defaultKids: 7,
        seniorCitizens: 7,
        idProofName: 'jessicaleeid.pdf',
      ),
      Room(
        code: '108',
        type: 'Deluxe Room',
        pricePerNight: 1800.0,
        maxGuests: 2,
        gstPercentage: 12.0,
        status: RoomStatus.available,
        floor: 1,
        tenantName: 'David Wilson',
        defaultAdults: 2,
        defaultKids: 8,
        seniorCitizens: 0,
        idProofName: 'davidwilsonid.pdf',
      ),
      Room(
        code: '109',
        type: 'Executive Suite',
        pricePerNight: 1900.0,
        maxGuests: 3,
        gstPercentage: 18.0,
        status: RoomStatus.occupied,
        floor: 1,
        tenantName: 'Sophia Martinez',
        defaultAdults: 2,
        defaultKids: 9,
        seniorCitizens: 0,
        idProofName: 'sophiamartin.pdf',
      ),
      Room(
        code: '110',
        type: 'Family Room',
        pricePerNight: 2000.0,
        maxGuests: 4,
        gstPercentage: 12.0,
        status: RoomStatus.available,
        floor: 1,
        tenantName: 'Daniel Garcia',
        defaultAdults: 2,
        defaultKids: 10,
        seniorCitizens: 0,
        idProofName: 'danielgarciaid.pdf',
      ),
      Room(
        code: '111',
        type: 'Family Room',
        pricePerNight: 2100.0,
        maxGuests: 4,
        gstPercentage: 12.0,
        status: RoomStatus.available,
        floor: 1,
        tenantName: 'Olivia Rodriguez',
        defaultAdults: 2,
        defaultKids: 11,
        seniorCitizens: 0,
        idProofName: 'oliviarodrigue.pdf',
      ),
    ];
  }
}
