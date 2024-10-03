part of "../export.provider.dart";

class TripStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class TripInitial extends TripStates {}

class TripsLoading extends TripStates {}

class TripCreated extends TripStates {
  final Trip trip;
  TripCreated({required this.trip});
  @override
  List<Object?> get props => [trip];
}

class TripUpdated extends TripStates {
  final Trip trip;
  TripUpdated({required this.trip});
  @override
  List<Object?> get props => [trip];
}

class TripDeleted extends TripStates {}

class TripsLoaded extends TripStates {
  final List<Trip> trips;
  TripsLoaded({required this.trips});
  @override
  List<Object?> get props => [trips];
}

// tripdetails
class TripDetailsLoaded extends TripStates {
  final Trip trip;
  TripDetailsLoaded({required this.trip});
  @override
  List<Object?> get props => [trip];
}

class TripError extends TripStates {
  final String message;
  TripError({required this.message});
  @override
  List<Object?> get props => [message];
}
