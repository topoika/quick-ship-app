part of "../export.provider.dart";

// class TripBloc
class TripBloc extends Bloc<TripEvents, TripStates> {
  TripRepo repo = TripRepo();

  // use on
  TripBloc() : super(TripInitial()) {
    on<CreateTripEvent>(createTrip);
    on<FetchUserTripsEvent>(getUserTrips);
    on<DeleteTripEvent>(deleteTrip);
  }

  void createTrip(event, emit) async {
    emit(TripsLoading());
    try {
      final trip = await repo.createTrip(trip: event.trip);
      emit(TripCreated(trip: trip));
    } catch (e) {
      emit(TripError(message: e.toString()));
    }
  }

  void getUserTrips(event, emit) async {
    emit(TripsLoading());
    try {
      final trips = await repo.getUserTrips();
      emit(TripsLoaded(trips: trips));
    } catch (e) {
      emit(TripError(message: e.toString()));
    }
  }

  void deleteTrip(event, emit) async {
    emit(TripsLoading());
    try {
      await repo.deleteTrip(id: event.id);
      emit(TripDeleted());
    } catch (e) {
      emit(TripError(message: e.toString()));
    }
  }
}

// route trips bloc
class RouteTripsBloc extends Bloc<TripEvents, TripStates> {
  TripRepo repo = TripRepo();
  RouteTripsBloc() : super(TripInitial()) {
    on<FetchRouteTripsEvent>(fetchRouteTrips);
  }

  void fetchRouteTrips(event, emit) async {
    emit(TripsLoading());
    try {
      final trips = await repo.getRouteTrips(
          destination: event.destination, departure: event.departure);
      emit(TripsLoaded(trips: trips));
    } catch (e) {
      emit(TripError(message: e.toString()));
    }
  }
}

// Trip Details Bloc
class TripDetailsBloc extends Bloc<TripEvents, TripStates> {
  TripRepo repo = TripRepo();
  TripDetailsBloc() : super(TripInitial()) {
    on<FetchTripDetailsEvent>(fetchTripDetails);
  }

  void fetchTripDetails(event, emit) async {
    emit(TripsLoading());
    try {
      final trip = await repo.getTripDetails(id: event.id);
      emit(TripDetailsLoaded(trip: trip));
    } catch (e) {
      emit(TripError(message: e.toString()));
    }
  }
}
