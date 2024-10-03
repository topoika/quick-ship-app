part of "../data.dart";

class Trip {
  int? id;
  TravelMethod? travelMethod;
  String? travelRole;
  bool? allowRequest;
  String? status;
  String? guideToMeetingPoint;
  String? packagePreference;
  double? postageFee;
  String? licenseNumber;
  String? vehicleIdentity;
  Address? departure;
  Address? destination;
  User? postman;
  Trip({
    this.id,
    this.travelMethod,
    this.travelRole,
    this.allowRequest,
    this.status,
    this.guideToMeetingPoint,
    this.packagePreference,
    this.postageFee,
    this.licenseNumber,
    this.vehicleIdentity,
    this.departure,
    this.destination,
    this.postman,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'travelMethodId': travelMethod?.id,
      'travelRole': travelRole,
      'allowRequest': allowRequest ?? true,
      'status': status ?? "pending",
      'guideToMeetingPoint': guideToMeetingPoint,
      'packagePreference': packagePreference,
      'postageFee': postageFee,
      'licenseNumber': licenseNumber,
      'vehicleIdentity': vehicleIdentity,
      'departureAddress': departure?.toMap(),
      'destinationAddress': destination?.toMap(),
      'postman': postman?.toMap(),
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] != null ? map['id'] as int : null,
      travelMethod: map['travelMethodId'] != null
          ? travelMethods.firstWhere(
              (element) => element.id == map['travelMethodId'],
              orElse: () => TravelMethod(),
            )
          : null,
      travelRole:
          map['travelRole'] != null ? map['travelRole'] as String : null,
      allowRequest:
          map['allowRequest'] != null ? map['allowRequest'] as bool : null,
      status: map['status'] != null ? map['status'] as String : null,
      guideToMeetingPoint: map['guideToMeetingPoint'] != null
          ? map['guideToMeetingPoint'] as String
          : null,
      packagePreference: map['packagePreference'] != null
          ? map['packagePreference'] as String
          : null,
      postageFee: map['postageFee'] != null
          ? double.parse(map['postageFee'].toString())
          : null,
      licenseNumber:
          map['licenseNumber'] != null ? map['licenseNumber'] as String : null,
      vehicleIdentity: map['vehicleIdentity'] != null
          ? map['vehicleIdentity'] as String
          : null,
      departure: map['departure'] != null
          ? Address.fromMap(map['departure'] as Map<String, dynamic>)
          : null,
      destination: map['destination'] != null
          ? Address.fromMap(map['destination'] as Map<String, dynamic>)
          : null,
      postman: map['postman'] != null
          ? User.fromMap(map['postman'] as Map<String, dynamic>)
          : null,
    );
  }
}

class TravelMethod {
  int? id;
  String? name;
  String? icon;
  Color? color;
  TravelMethod({
    this.id,
    this.name,
    this.icon,
    this.color,
  });
}

List<TravelMethod> travelMethods = [
  // TravelMethod(
  //   id: 1,
  //   name: "Air",
  //   icon: AppStrings.airIcon,
  //   color: const Color(0xff6B68FF),
  // ),
  TravelMethod(
    id: 2,
    name: "Bus",
    icon: AppStrings.busIcon,
    color: const Color(0xff01CAFE),
  ),
  TravelMethod(
    id: 3,
    name: "Car",
    icon: AppStrings.carIcon,
    color: Colors.green,
  ),
  TravelMethod(
    id: 4,
    name: "Train",
    icon: AppStrings.trainIcon,
    color: const Color.fromARGB(255, 6, 4, 102),
  ),
  TravelMethod(
    id: 5,
    name: "Bike",
    icon: AppStrings.bikeIcon,
    color: const Color(0xffFF7F00),
  ),
  TravelMethod(
    id: 6,
    name: "Van",
    icon: AppStrings.vanIcon,
    color: const Color.fromARGB(255, 187, 5, 5),
  ),
];
