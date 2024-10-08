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

  String? date;
  String? time;

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
    this.date,
    this.time,
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
      'dateAndTime': formatToDateAndTime(date: date, time: time).toString(),
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
      latitude: map['latitude'] != null
          ? double.parse(map['latitude'].toString())
          : null,
      longitude: map['longitude'] != null
          ? double.parse(map['longitude'].toString())
          : null,
      meetingPoint:
          map['meetingPoint'] != null ? map['meetingPoint'] as String : null,
      dateAndTime:
          map['dateAndTime'] != null ? map['dateAndTime'] as String : null,
    );
  }
}
