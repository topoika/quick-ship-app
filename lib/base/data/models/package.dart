part of "../data.dart";

class Package {
  int? id;
  User? shipper;
  Address? sourceAddress;
  Address? destinationAddress;
  List<PackageImage>? images;
  String? name;
  String? description;
  String? status;
  String? postManNote;
  String? dateOfShipment;
  bool? packBySender;
  bool? insurance;
  double? value;
  double? approximateValue;
  double? dimLength;
  double? dimWidth;
  double? dimHeight;
  double? weight;
  String? recieverName;
  String? recieverPhone;
  String? recieverAltPhone;
  Package({
    this.id,
    this.shipper,
    this.sourceAddress,
    this.destinationAddress,
    this.images,
    this.name,
    this.description,
    this.status,
    this.postManNote,
    this.dateOfShipment,
    this.packBySender,
    this.insurance,
    this.value,
    this.approximateValue,
    this.dimLength,
    this.dimWidth,
    this.dimHeight,
    this.weight,
    this.recieverName,
    this.recieverPhone,
    this.recieverAltPhone,
  });
}

class PackageImage {
  int? id;
  int? packageId;
  String? url;
  PackageImage({
    this.id,
    this.packageId,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'packageId': packageId,
      'url': url,
    };
  }

  factory PackageImage.fromMap(Map<String, dynamic> map) {
    return PackageImage(
      id: map['id'] != null ? map['id'] as int : null,
      packageId: map['packageId'] != null ? map['packageId'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }
}
