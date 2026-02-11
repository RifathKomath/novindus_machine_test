class GetBranchResponse {
    bool? status;
    String? message;
    List<BranchData>? branches;

    GetBranchResponse({
        this.status,
        this.message,
        this.branches,
    });

    factory GetBranchResponse.fromJson(Map<String, dynamic> json) => GetBranchResponse(
        status: json["status"],
        message: json["message"],
        branches: json["branches"] == null ? [] : List<BranchData>.from(json["branches"]!.map((x) => BranchData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
    };
}

class BranchData {
    int? id;
    String? name;
    int? patientsCount;
    String? location;
    String? phone;
    String? mail;
    String? address;
    String? gst;
    bool? isActive;

    BranchData({
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

    factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
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
