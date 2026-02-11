class GetPatientResponse {
  bool? status;
  String? message;
  List<Patient>? patient;

  GetPatientResponse({this.status, this.message, this.patient});

  factory GetPatientResponse.fromJson(Map<String, dynamic> json) =>
      GetPatientResponse(
        status: json["status"],
        message: json["message"],
        patient: json["patient"] == null
            ? []
            : List<Patient>.from(
                json["patient"]!.map((x) => Patient.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "patient": patient == null
        ? []
        : List<dynamic>.from(patient!.map((x) => x.toJson())),
  };
}

class Patient {
  int? id;
  List<PatientdetailsSet>? patientdetailsSet;
  Branch? branch;
  String? user;
  String? payment;
  String? name;
  String? phone;
  String? address;
  dynamic price;
  int? totalAmount;
  int? discountAmount;
  int? advanceAmount;
  int? balanceAmount;
  DateTime? dateNdTime;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Patient({
    this.id,
    this.patientdetailsSet,
    this.branch,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    patientdetailsSet: json["patientdetails_set"] == null
        ? []
        : List<PatientdetailsSet>.from(
            json["patientdetails_set"]!.map(
              (x) => PatientdetailsSet.fromJson(x),
            ),
          ),
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    user: json["user"],
    payment: json["payment"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    price: json["price"],
    totalAmount: json["total_amount"],
    discountAmount: json["discount_amount"],
    advanceAmount: json["advance_amount"],
    balanceAmount: json["balance_amount"],
    dateNdTime: json["date_nd_time"] == null
        ? null
        : DateTime.parse(json["date_nd_time"]),
    isActive: json["is_active"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patientdetails_set": patientdetailsSet == null
        ? []
        : List<dynamic>.from(patientdetailsSet!.map((x) => x.toJson())),
    "branch": branch?.toJson(),
    "user": user,
    "payment": payment,
    "name": name,
    "phone": phone,
    "address": address,
    "price": price,
    "total_amount": totalAmount,
    "discount_amount": discountAmount,
    "advance_amount": advanceAmount,
    "balance_amount": balanceAmount,
    "date_nd_time": dateNdTime?.toIso8601String(),
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Branch {
  int? id;
  String? name;
  int? patientsCount;
  String? location;
  String? phone;
  String? mail;
  String? address;
  String? gst;
  bool? isActive;

  Branch({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
    patientsCount: json["patients_count"],
    location: json["location"],
    phone: json["phone"],
    mail: json["mail"],
    address: json["address"],
    gst: json["gst"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "patients_count": patientsCount,
    "location": location,
    "phone": phone,
    "mail": mail,
    "address": address,
    "gst": gst,
    "is_active": isActive,
  };
}

class PatientdetailsSet {
  int? id;
  String? male;
  String? female;
  int? patient;
  int? treatment;
  String? treatmentName;

  PatientdetailsSet({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
  });

  factory PatientdetailsSet.fromJson(Map<String, dynamic> json) =>
      PatientdetailsSet(
        id: json["id"],
        male: json["male"],
        female: json["female"],
        patient: json["patient"],
        treatment: json["treatment"],
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "male": male,
    "female": female,
    "patient": patient,
    "treatment": treatment,
    "treatment_name": treatmentName,
  };
}
