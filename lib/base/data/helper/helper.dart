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
  final DateTime dateTime = DateFormat('yyyy-MM-dd hh:mm a').parse(date);
  return DateFormat('MMM d, hh:mm a').format(dateTime);
}

String formatToTime({required DateTime date}) {
  return DateFormat('hh:mm a').format(date);
}

DateTime formatToDateAndTime({required String date, required String time}) {
  final DateTime dateTime =
      DateFormat('yyyy-MM-dd hh:mm a').parse('$date $time');
  return dateTime;
}

String? capitalize(String? s) {
  if (s == null || s.isEmpty) {
    return null;
  }
  return s[0].toUpperCase() + s.substring(1);
}

// write a function to return an address name from the address model
String getAddressName(Address address) {
  String name = "";

  if (address.nameAddress != null) {
    name += "${capitalize(address.nameAddress)}";
  }

  if (address.city != null) {
    name += " - ${capitalize(address.city) ?? "N/A"}";
  }
  return name;
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
            log("Place picked: $result");
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
          nameAddress: result.formattedAddress ?? "Unkown Address",
          dateAndTime: address?.dateAndTime,
          meetingPoint: address?.meetingPoint,
        );
      } else {
        showCustomToast(message: "No placemarks found", type: "err");
      }
    }
    return null;
  } catch (e) {
    log("Error picking location: $e");
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
