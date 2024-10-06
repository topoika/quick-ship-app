part of "../export.provider.dart";

class DetailsItemCubit extends Cubit<DetailsItemState> {
  DetailsItemCubit() : super(DetailsItemState.initial());

  void setTripId(int tripId) {
    emit(state.copyWith(tripId: tripId));
  }

  void setPackageId(int packageId) {
    emit(state.copyWith(packageId: packageId));
  }

  void setRating(int rating) {
    emit(state.copyWith(rating: rating));
  }

  void updateState(DetailsItemState state) {
    emit(state);
  }

  void setTip(double tip) {
    emit(state.copyWith(tip: tip));
  }

  void reset() {
    emit(DetailsItemState.initial());
  }

  void setAddreses(Package package) {
    emit(state.copyWith(
        from: package.sourceAddress, to: package.destinationAddress));
  }
}

class DetailsItemState {
  int? tripId;
  int? packageId;
  int? rating;
  double? tip;
  Address? from;
  Address? to;

  DetailsItemState({
    this.tripId,
    this.packageId,
    this.rating,
    this.tip,
    this.from,
    this.to,
  });

  factory DetailsItemState.initial() {
    return DetailsItemState(
      tripId: 1,
      packageId: 1,
      rating: 5,
      tip: 0.0,
    );
  }

  DetailsItemState copyWith({
    int? tripId,
    int? packageId,
    int? rating,
    double? tip,
    Address? from,
    Address? to,
  }) {
    return DetailsItemState(
      tripId: tripId ?? this.tripId,
      packageId: packageId ?? this.packageId,
      rating: rating ?? this.rating,
      tip: tip ?? this.tip,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}
