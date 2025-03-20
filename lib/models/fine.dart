class Fine {
  final String tagCode;
  final String brand;
  final String model;
  final String color;
  final int year;
  final String licensePlate;
  final String violationType;
  final double? latitude;
  final double? longitude;
  final DateTime timestamp;
  final String description;
  final String imagePath;
  final String audioRecordPath;

  Fine({
    required this.tagCode,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.licensePlate,
    required this.violationType,
    this.latitude,
    this.longitude,
    required this.timestamp,
    required this.description,
    required this.imagePath,
    required this.audioRecordPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'tag_code': tagCode,
      'brand': brand,
      'model': model,
      'color': color,
      'year': year,
      'license_plate': licensePlate,
      'violation_type': violationType,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'description': description,
      'image_path': imagePath,
      'audio_record_path': audioRecordPath,
    };
  }

  static Fine fromMap(Map<String, dynamic> map) {
    return Fine(
      tagCode: map['tag_code'],
      brand: map['brand'],
      model: map['model'],
      color: map['color'],
      year: map['year'],
      licensePlate: map['license_plate'],
      violationType: map['violation_type'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      description: map['description'],
      imagePath: map['image_path'],
      audioRecordPath: map['audio_record_path'],
    );
  }
}
