part of "../export.provider.dart";

class DetailsItemCubit extends Cubit<DetailsItemState> {
  DetailsItemCubit() : super(DetailsItemState.initial());

  void setId(int id) {
    emit(state.copyWith(id: id));
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
}

class DetailsItemState {
  int? id;
  int? rating;
  double? tip;

  DetailsItemState({
    this.id,
    this.rating,
    this.tip,
  });

  factory DetailsItemState.initial() {
    return DetailsItemState(
      id: 1,
      rating: 5,
      tip: 0.0,
    );
  }

  DetailsItemState copyWith({
    int? id,
    int? rating,
    double? tip,
  }) {
    return DetailsItemState(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      tip: tip ?? this.tip,
    );
  }
}
