part of "../export.provider.dart";

// NewItemCubit
class NewItemCubit extends Cubit<NewItemState> {
  NewItemCubit() : super(NewItemState.initial());

  // setTrip
  void setTrip(Trip trip) {
    emit(state.copyWith(trip: trip));
  }

  // setPackage
  void setPackage(Package package) {
    emit(state.copyWith(package: package));
  }

  // clear
  void clear() {
    emit(NewItemState.initial());
  }

  Trip get trip => state.trip!;

  Package get package => state.package!;
}

class NewItemState {
  Trip? trip;
  Package? package;

  NewItemState({this.trip, this.package});

  // initial state
  factory NewItemState.initial() {
    return NewItemState(
      trip: Trip(
        departure: Address(),
        destination: Address(),
        travelRole: "Passenger",
        travelMethod: travelMethods.first,
      ),
      package: Package(
        sourceAddress: Address(),
        destinationAddress: Address(),
        insurance: false,
        packBySender: true,
      ),
    );
  }

  // copyWith
  NewItemState copyWith({
    Trip? trip,
    Package? package,
  }) {
    return NewItemState(
      trip: trip ?? this.trip,
      package: package ?? this.package,
    );
  }
}
