part of "../data.dart";

class PackageRequest {
  int? id;
  Package? pakage;
  Trip? trip;
  String? status;
  double? postageFee;
  String? createdAt;
  PackageRequest({
    this.id,
    this.pakage,
    this.trip,
    this.status,
    this.postageFee,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pakage': pakage?.toMap(),
      'trip': trip?.toMap(),
      'status': status,
      'postageFee': postageFee,
      'createdAt': createdAt,
    };
  }

  factory PackageRequest.fromMap(Map<String, dynamic> map) {
    return PackageRequest(
      id: map['id'] != null ? map['id'] as int : null,
      pakage: map['pakage'] != null
          ? Package.fromMap(map['pakage'] as Map<String, dynamic>)
          : null,
      trip: map['trip'] != null
          ? Trip.fromMap(map['trip'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      postageFee: map['postageFee'] != null
          ? double.parse(map['postageFee'].toString())
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }
}
