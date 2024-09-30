part of "../data.dart";

class Address {
  int? id;
  String? country;
  String? state;
  String? city;
  String? nameAddress;
  double? latitude;
  double? longitude;
  String? meetingPoint;
  String? dateAndTime;

  Address({
    this.id,
    this.country,
    this.state,
    this.city,
    this.nameAddress,
    this.latitude,
    this.longitude,
    this.meetingPoint,
    this.dateAndTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country': country,
      'state': state,
      'city': city,
      'nameAddress': nameAddress,
      'latitude': latitude,
      'longitude': longitude,
      'meetingPoint': meetingPoint,
      'dateAndTime': dateAndTime,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] != null ? map['id'] as int : null,
      country: map['country'] != null ? map['country'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      nameAddress:
          map['nameAddress'] != null ? map['nameAddress'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      meetingPoint:
          map['meetingPoint'] != null ? map['meetingPoint'] as String : null,
      dateAndTime:
          map['dateAndTime'] != null ? map['dateAndTime'] as String : null,
    );
  }
}
