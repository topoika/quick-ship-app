part of "../data.dart";

String formatCurrency({dynamic value}) {
  final formatter = NumberFormat.currency(
    locale: 'en',
    symbol: 'KSH',
    decimalDigits: 0,
  );
  return formatter.format(double.parse(value.toString()));
}

String formatToDate({required DateTime date}) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String tripDateFormat({required String date}) {
  final DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm:').parse(date);
  return DateFormat('MMM d, hh:mm a').format(dateTime);
}

String formatToTimeAndDate({required DateTime date}) {
  return DateFormat('MMM d, hh:mm a').format(date);
}

String formatToTime({required DateTime date}) {
  return DateFormat('hh:mm a').format(date);
}

DateTime? formatToDateAndTime({String? date, String? time}) {
  if (date == null || time == null) {
    return null;
  }

  print('Date: $date, Time: $time');
  final DateTime dateTime =
      DateFormat('yyyy-MM-dd hh:mm a').parse('$date $time');
  print('Date: $dateTime, Time: $time');

  return dateTime;
}

String? capitalize(String? s) {
  if (s == null || s.isEmpty) {
    return null;
  }
  return s[0].toUpperCase() + s.substring(1);
}

String getTimeFromTimestamp(Timestamp timeStamp) =>
    timeStamp.toDate().toString();

// write a function to return an address name from the address model
String getAddressName(Address? address) {
  if (address == null) {
    return "";
  }
  String name = "";

  if (address.nameAddress != null) {
    name += "${capitalize(address.nameAddress)}";
  }

  if (address.city != null) {
    name += " - ${capitalize(address.city) ?? capitalize(address.state)}";
  }
  return name.replaceAll("County", "");
}

Future<Address?> pickLocation(
    {Address? address, required BuildContext context}) async {
  try {
    PickResult? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: "AIzaSyAqTWxt9ryyEjchATORRXb4sHmROgWbFHI",
          initialPosition: const LatLng(56.1304, 106.3468),
          useCurrentLocation: true,
          onPlacePicked: (result) {
            Navigator.of(context).pop(result);
          },
        ),
      ),
    );

    if (result != null && result.geometry != null) {
      final lat = result.geometry!.location.lat;
      final lng = result.geometry!.location.lng;
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return Address(
          country: place.country,
          state: place.administrativeArea ?? '',
          latitude: lat,
          longitude: lng,
          city: place.locality,
          nameAddress: result.name ?? result.formattedAddress,
          dateAndTime: address?.dateAndTime,
          meetingPoint: address?.meetingPoint,
        );
      } else {
        showCustomToast(message: "No placemarks found", type: "err");
      }
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime? selectedDate;

  selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 1),
  );

  DateTime selectedDateTime = DateTime(
    selectedDate!.year,
    selectedDate.month,
    selectedDate.day,
  );

  return selectedDateTime;
}

Future<DateTime?> pickTime(BuildContext context) async {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  selectedDate = DateTime.now();
  selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (selectedTime != null) {
    DateTime selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    return selectedDateTime;
  }

  return null;
}

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate({required this.latitude, required this.longitude});
}

Future<double?> calculateDistanceToPoint(Coordinate point) async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return calculateDistance(
    Coordinate(latitude: position.latitude, longitude: position.longitude),
    point,
  );
}

String getTimeOnly(String time) => DateFormat.jm().format(DateTime.parse(time));
String getDateString(DateTime date) {
  DateTime now = DateTime.now();
  int difference = now.day - date.day;
  if (difference == 0) {
    return "Today";
  } else if (difference == 1) {
    return "Yesterday";
  } else if (difference > 1 && difference <= 7) {
    return DateFormat('EEEE').format(date); // Day of the week
  } else {
    return DateFormat('yyyy-MM-dd').format(date); // Date format
  }
}

double calculateDistance(Coordinate poinT1, Coordinate point2) {
  const earthRadiusKm = 6371;

  final lat1 = poinT1.latitude * math.pi / 180;
  final lon1 = poinT1.longitude * math.pi / 180;
  final lat2 = point2.latitude * math.pi / 180;
  final lon2 = point2.longitude * math.pi / 180;

  final dLat = lat2 - lat1;
  final dLon = lon2 - lon1;

  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  final distance = earthRadiusKm * c;

  return distance;
}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return DateFormat('E, d MMM yyyy').format(dateTime);
  } else if (difference.inHours > 0) {
    return DateFormat.jm().format(dateTime);
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} Min';
  } else {
    return 'Just now';
  }
}
