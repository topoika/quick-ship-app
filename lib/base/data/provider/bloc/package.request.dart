part of "../export.provider.dart";

// PackageRequestBloc
class PackageRequestBloc
    extends Bloc<PackageRequestEvents, PackageRequestStates> {
  PackageRequestRepo repo = PackageRequestRepo();
  PackageRequestBloc() : super(PackageRequestInitState()) {
    on<CreatePackageRequestEvent>(createPackageRequest);
    on<FetchPackageRequestsEvent>(fetchPackageRequests);
    on<DeclinePackageRequestEvent>(declinePackageRequest);
    on<AcceptPackageRequestEvent>(acceptPackageRequest);
  }
  // create package request
  void createPackageRequest(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      final packageRequest = await repo.createPackageRequest(
          packageId: event.packageId, tripId: event.tripId);
      emit(PackageRequestCreatedState(packageRequest: packageRequest));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // fetch package requests
  void fetchPackageRequests(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      final packageRequests = await repo.fetchPackageRequests(id: event.id);
      emit(PackageRequestLoadedState(packageRequests: packageRequests));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // accept package request
  void acceptPackageRequest(event, emit) async {
    emit(RequestAccepting());
    try {
      final packageRequest = await repo.acceptPackageRequest(id: event.id);
      emit(PackageRequestAcceptedState(packageRequest: packageRequest));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // decline package request
  void declinePackageRequest(event, emit) async {
    emit(RequestDeclining());
    try {
      final packageRequest = await repo.declinePackageRequest(id: event.id);
      emit(PackageRequestDeclinedState(packageRequest: packageRequest));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }
}

class PackageRequestDetailsBloc
    extends Bloc<PackageRequestEvents, PackageRequestStates> {
  PackageRequestRepo repo = PackageRequestRepo();
  PackageRequestDetailsBloc() : super(PackageRequestInitState()) {
    on<FetchPackageRequestDetailsEvent>(fetchPackageRequestDetails);
  }

  void fetchPackageRequestDetails(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      final packageRequest =
          await repo.fetchPackageRequestDetails(id: event.id);
      emit(PackageRequestDetailsLoadedState(packageRequest: packageRequest));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }
}
