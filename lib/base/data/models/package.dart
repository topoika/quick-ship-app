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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sourceAddress': json.encode(sourceAddress?.toMap()),
      'destinationAddress': json.encode(destinationAddress?.toMap()),
      'name': name,
      'description': description,
      'status': status,
      'postManNote': postManNote,
      'dateOfShipment': dateOfShipment,
      'packBySender': packBySender,
      'insurance': insurance,
      'value': value,
      'approximateValue': approximateValue,
      'dimLength': dimLength,
      'dimWidth': dimWidth,
      'dimHeight': dimHeight,
      'weight': weight,
      'recieverName': recieverName,
      'recieverPhone': recieverPhone,
      'recieverAltPhone': recieverAltPhone,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      id: map['id'] != null ? map['id'] as int : null,
      shipper: map['shipper'] != null
          ? User.fromMap(map['shipper'] as Map<String, dynamic>)
          : null,
      sourceAddress: map['sourceAddress'] != null
          ? Address.fromMap(map['sourceAddress'] as Map<String, dynamic>)
          : null,
      destinationAddress: map['destinationAddress'] != null
          ? Address.fromMap(map['destinationAddress'] as Map<String, dynamic>)
          : null,
      images: map['images'] != null
          ? List<PackageImage>.from(
              (map['images'] as List<dynamic>).map<PackageImage?>(
                (x) => PackageImage.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      postManNote:
          map['postManNote'] != null ? map['postManNote'] as String : null,
      dateOfShipment: map['dateOfShipment'] != null
          ? map['dateOfShipment'] as String
          : null,
      packBySender:
          map['packBySender'] != null ? map['packBySender'] as bool : null,
      insurance: map['insurance'] != null ? map['insurance'] as bool : null,
      value:
          map['value'] != null ? double.parse(map['value'].toString()) : null,
      approximateValue: map['approximateValue'] != null
          ? double.parse(map['approximateValue'].toString())
          : null,
      dimLength: map['dimLength'] != null
          ? double.parse(map['dimLength'].toString())
          : null,
      dimWidth: map['dimWidth'] != null
          ? double.parse(map['dimWidth'].toString())
          : null,
      dimHeight: map['dimHeight'] != null
          ? double.parse(map['dimHeight'].toString())
          : null,
      weight:
          map['weight'] != null ? double.parse(map['weight'].toString()) : null,
      recieverName:
          map['recieverName'] != null ? map['recieverName'] as String : null,
      recieverPhone:
          map['recieverPhone'] != null ? map['recieverPhone'] as String : null,
      recieverAltPhone: map['recieverAltPhone'] != null
          ? map['recieverAltPhone'] as String
          : null,
    );
  }
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
      url: map['url'] != null
          ? "http://15.237.218.2:9000/uploads/media/${map['url']}"
          : null,
    );
  }
}
