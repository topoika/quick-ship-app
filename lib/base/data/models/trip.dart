part of "../data.dart";

class Trip {
  int? id;
  TravelMethod? travelMethod;
  String? travelRole;
  bool? allowRequest;
  String? status;
  String? guideToMeetingPoint;
  String? packagePreference;
  double?postageFee;
  

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
  TravelMethod(
    id: 1,
    name: "Air",
    icon: AppStrings.airIcon,
    color: const Color(0xff6B68FF),
  ),
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
  // TravelMethod(
  //   id: 6,
  //   name: "Van",
  //   icon: AppStrings.vanIcon,
  //   color: const Color.fromARGB(255, 187, 5, 5),
  // ),
];
