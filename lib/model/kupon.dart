class Kupon {
  final List<Datum> data;

  Kupon({
    required this.data,
  });

}

class Datum {
  final int id;
  final int userId;
  final String name;
  final String asrama;
  final String qrCode;
  final DateTime createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Datum({
    required this.id,
    required this.userId,
    required this.name,
    required this.asrama,
    required this.qrCode,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

}
