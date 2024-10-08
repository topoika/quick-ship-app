part of "../export.provider.dart";

class DetailsItemCubit extends Cubit<DetailsItemState> {
  DetailsItemCubit() : super(DetailsItemState.initial());

  void setTripId(int tripId) {
    emit(state.copyWith(tripId: tripId));
  }

  void setOrderId(int orderId) {
    emit(state.copyWith(orderId: orderId));
  }

  void setPackageId(int packageId) {
    emit(state.copyWith(packageId: packageId));
  }

  void setRequestId(int requestId) {
    emit(state.copyWith(requestId: requestId));
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

  void setViewedNotification(List<int> ids) {
    emit(state.copyWith(viewedNotification: ids));
  }

  List<int> get viewedNotification => state.viewedNotification ?? [];
}

class DetailsItemState {
  int? tripId;
  int? packageId;
  int? requestId;
  int? orderId;
  int? rating;
  double? tip;
  Address? from;
  Address? to;
  List<int>? viewedNotification;

  DetailsItemState({
    this.tripId,
    this.packageId,
    this.requestId,
    this.orderId,
    this.rating,
    this.tip,
    this.from,
    this.to,
    this.viewedNotification,
  });

  factory DetailsItemState.initial() {
    return DetailsItemState(
      tripId: 1,
      packageId: 1,
      requestId: 1,
      orderId: 1,
      rating: 5,
      tip: 0.0,
      viewedNotification: makeIntList("viewedNotification"),
    );
  }

  DetailsItemState copyWith({
    int? tripId,
    int? packageId,
    int? rating,
    int? requestId,
    int? orderId,
    double? tip,
    Address? from,
    Address? to,
    List<int>? viewedNotification,
  }) {
    return DetailsItemState(
      tripId: tripId ?? this.tripId,
      packageId: packageId ?? this.packageId,
      requestId: requestId ?? this.requestId,
      rating: rating ?? this.rating,
      orderId: orderId ?? this.orderId,
      tip: tip ?? this.tip,
      from: from ?? this.from,
      to: to ?? this.to,
      viewedNotification: viewedNotification ?? this.viewedNotification,
    );
  }
}

List<int> makeIntList(String key) {
  String? value = Storage.getData(key, defaultValue: "");
  if (value == null || value.isEmpty) {
    return [];
  }
  return value.split(",").map((e) => int.parse(e)).toList();
}
