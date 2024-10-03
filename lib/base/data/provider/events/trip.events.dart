part of "../export.provider.dart";

class TripEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTripEvent extends TripEvents {
  final Trip trip;
  CreateTripEvent({required this.trip});
}

class UpdateTripEvent extends TripEvents {
  final Trip trip;
  UpdateTripEvent({required this.trip});
}

class DeleteTripEvent extends TripEvents {
  final Trip trip;
  DeleteTripEvent({required this.trip});
}

class FetchTripEvent extends TripEvents {
  final int? id;
  FetchTripEvent({required this.id});
}

class FetchTripDetailsEvent extends TripEvents {
  final int id;
  FetchTripDetailsEvent({required this.id});
}

class FetchUserTripsEvent extends TripEvents {}

class FetchRouteTripEvent extends TripEvents {
  final Package package;
  FetchRouteTripEvent({required this.package});
}
