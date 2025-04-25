class DoctorResponse {
  final List<Doctor> doctors;
  final int totalCount;

  DoctorResponse({
    required this.doctors,
    required this.totalCount,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
      doctors: List<Doctor>.from(json['doctors'].map((x) => Doctor.fromJson(x))),
      totalCount: json['totalCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctors': doctors.map((x) => x.toJson()).toList(),
      'totalCount': totalCount,
    };
  }
}

class Doctor {
  final String id;
  final Specialization specialization;
  final int consultationFees;
  final String locations;

  Doctor({
    required this.id,
    required this.specialization,
    required this.consultationFees,
    required this.locations,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      specialization: Specialization.fromJson(json['specialization']),
      consultationFees: json['consultationFees'],
      locations: json['locations'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'specialization': specialization.toJson(),
      'consultationFees': consultationFees,
      'locations': locations,
    };
  }
}

class Specialization {
  final String id;
  final String name;

  Specialization({
    required this.id,
    required this.name,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
